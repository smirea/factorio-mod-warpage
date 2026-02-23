import type {
	BoundingBox,
	LuaForce,
	LuaSurface,
	MapPosition,
	NthTickEventData,
	OnScriptTriggerEffectEvent,
	UnitNumber,
} from 'factorio:runtime';
import { names } from './constants';
import { on_event, on_nth_tick } from '@/utils';

const IMPACT_EFFECT_ID = names.projectile;

const PRODUCTIVITY_TECHNOLOGY_NAMES = [1, 2, 3, 4, 5].map(level => names.ns('mining-productivity-' + level));
const RADIUS_TECHNOLOGY_NAMES = [1, 2, 3].map(level => names.ns('mining-radius-' + level));

const BASE_PRODUCTIVITY_MULTIPLIER = 1;
const FLAME_LIFETIME_TICKS = 60 * 3;
const RESCUE_COOLDOWN_TICKS = 60 * 60 * 10;

const ORE_DROP_STACK_SIZE = 500;
const ORE_DEFAULT_MULTIPLIER = 0.5;
const ORE_MULTIPLIER_BY_ITEM_NAME = {
	'iron-ore': 1,
	'copper-ore': 1,
	coal: 0.75,
	stone: 0.5,
	calcite: 0.4,
	'tungsten-ore': 0.2,
	scrap: 1,
} as const;

function init() {
	on_event('on_script_trigger_effect', on_script_trigger_effect);

	on_nth_tick(1, handleBlastUpdates);

	on_event('on_research_finished', event => {
		if (storage.thermite_research_finished_tick || event.research.name !== names.recipe) return;

		const state = ensureThermiteState();
		if (!state.unlock_bonus_delivered) {
			// TODO: update these to use the hub composite entity once it's implemented
			// const force = requireForce(HUB_FORCE_NAME);
			// const technology = force.technologies[THERMITE_MINING_TECHNOLOGY_NAME];
			// if (!technology || !technology.researched) {
			// 	return;
			// }
			// deliverStacksToHub(force, [{ name: THERMITE_ITEM_NAME, count: UNLOCK_POD_STACK_COUNT }], UNLOCK_POD_COUNT);
			// state.unlock_bonus_delivered = true;
			// game.print('psst, look up, check the hub');
		}
	});
}

const requireSurfaceByIndex = (surfaceIndex: number): LuaSurface => {
	const surface = game.surfaces[surfaceIndex];
	if (!surface) throw new Error(`Missing surface index '${surfaceIndex}'.`);
	return surface;
};

const requireForce = (name: string): LuaForce => {
	const force = game.forces[name];
	if (!force) throw new Error(`Missing force '${name}'.`);
	return force;
};

function ensureThermiteState(): ThermiteMiningState {
	let state = storage.thermite_mining;
	if (!state) {
		state = {
			next_blast_id: 1,
			pending_blasts: {},
			unlock_bonus_delivered: false,
		};
		storage.thermite_mining = state;
	}

	const legacyLastRescueTick = storage.last_calcite_rescue_tick;
	if (legacyLastRescueTick !== undefined && storage.thermite_support_timeout === undefined) {
		storage.thermite_support_timeout = legacyLastRescueTick + RESCUE_COOLDOWN_TICKS;
	}
	storage.last_calcite_rescue_tick = undefined;

	return state;
}

function countResearchedLevels(force: LuaForce, technologies: ReadonlyArray<string>) {
	let researchedLevels = 0;
	for (const technologyName of technologies) {
		const technology = force.technologies[technologyName];
		if (technology && technology.researched) {
			researchedLevels += 1;
		}
	}
	return researchedLevels;
}

const oreYieldFormula = (removedAmount: number, productivityMultiplier: number, oreMultiplier: number) =>
	math.ceil(math.max(5, math.min(removedAmount / 100, 25)) * productivityMultiplier * oreMultiplier);

const resolveOreMultiplier = (itemName: string) =>
	itemName in ORE_MULTIPLIER_BY_ITEM_NAME
		? ORE_MULTIPLIER_BY_ITEM_NAME[itemName as keyof typeof ORE_MULTIPLIER_BY_ITEM_NAME]
		: ORE_DEFAULT_MULTIPLIER;

function spillItemInStacks(
	surface: LuaSurface,
	force: LuaForce,
	position: MapPosition,
	itemName: string,
	itemCount: number,
) {
	if (itemCount < 1) {
		throw new Error(`Thermite item spill count for '${itemName}' must be at least 1.`);
	}

	let remaining = itemCount;
	while (remaining > 0) {
		const stackCount = math.min(remaining, ORE_DROP_STACK_SIZE);
		surface.spill_item_stack({
			position,
			stack: { name: itemName, count: stackCount },
			enable_looted: true,
			force,
			allow_belts: true,
		});
		remaining -= stackCount;
	}
}

function removeOreResources(surface: LuaSurface, area: BoundingBox) {
	const resources = surface.find_entities_filtered({
		area,
		type: 'resource',
	});

	const removedByItem: Record<string, number | undefined> = {};
	for (const resource of resources) {
		if (!resource.valid) {
			continue;
		}

		const resourcePrototype = prototypes.entity[resource.name];
		if (!resourcePrototype || resourcePrototype.resource_category !== 'basic-solid') {
			continue;
		}

		const amount = resource.amount;
		if (amount > 0) {
			removedByItem[resource.name] = (removedByItem[resource.name] ?? 0) + amount;
		}

		const destroyed = resource.destroy();
		if (destroyed !== true && resource.valid) {
			throw new Error(`Failed to remove ore resource '${resource.name}' at thermite blast position.`);
		}
	}

	return removedByItem;
}

function dropOreYield(
	surface: LuaSurface,
	force: LuaForce,
	position: MapPosition,
	removedByItem: Record<string, number | undefined>,
	productivityMultiplier: number,
) {
	for (const [itemName, removedAmount] of pairs(removedByItem)) {
		if (!removedAmount || removedAmount <= 0) {
			continue;
		}
		const oreMultiplier = resolveOreMultiplier(itemName);
		const yieldCount = oreYieldFormula(removedAmount, productivityMultiplier, oreMultiplier);
		if (yieldCount < 1) {
			throw new Error(`Thermite ore yield for item '${itemName}' must be at least 1.`);
		}
		spillItemInStacks(surface, force, position, itemName, yieldCount);
	}
}

function cleanupBlastFlame(blast: ThermiteQueuedBlast) {
	if (blast.flame_unit_number === undefined) return;
	const flame = game.get_entity_by_unit_number(blast.flame_unit_number as UnitNumber);
	if (!flame || !flame.valid) return;
	flame.destroy();
}

function detonateBlast(blast: ThermiteQueuedBlast) {
	const surface = requireSurfaceByIndex(blast.surface_index);
	const force = requireForce(blast.force_name);
	const radius = 2 + countResearchedLevels(force, RADIUS_TECHNOLOGY_NAMES);
	const productivityMultiplier =
		BASE_PRODUCTIVITY_MULTIPLIER + countResearchedLevels(force, PRODUCTIVITY_TECHNOLOGY_NAMES);

	surface.create_entity({
		name: 'grenade-explosion',
		position: blast.position,
	});

	const removedByItem = removeOreResources(surface, {
		left_top: {
			x: blast.position.x - radius / 2,
			y: blast.position.y - radius / 2,
		},
		right_bottom: {
			x: blast.position.x + radius / 2,
			y: blast.position.y + radius / 2,
		},
	});

	spillItemInStacks(surface, force, blast.position, 'calcite', math.random(1, 5) * productivityMultiplier);
	dropOreYield(surface, force, blast.position, removedByItem, productivityMultiplier);
}

function on_script_trigger_effect(event: OnScriptTriggerEffectEvent) {
	if (event.effect_id !== IMPACT_EFFECT_ID) return;

	const position = event.target_position ?? event.source_position;
	if (!position) return;

	const surface = requireSurfaceByIndex(event.surface_index);

	const sourceEntity = event.source_entity;
	const causeEntity = event.cause_entity;
	if (!sourceEntity?.valid || !causeEntity?.valid) return;

	const state = ensureThermiteState();
	const blastId = state.next_blast_id;
	state.next_blast_id += 1;

	const flame = surface.create_entity({
		name: 'fire-flame',
		position,
		force: sourceEntity.force,
	});

	const blast: ThermiteQueuedBlast = {
		id: blastId,
		surface_index: event.surface_index,
		position,
		force_name: sourceEntity.force!.name,
		flame_cleanup_tick: event.tick + FLAME_LIFETIME_TICKS,
	};

	if (flame && flame.unit_number !== undefined) blast.flame_unit_number = flame.unit_number;

	state.pending_blasts[blastId] = blast;
	detonateBlast(blast);
}

function handleBlastUpdates(event: NthTickEventData) {
	const state = ensureThermiteState();

	const [firstPendingBlastId] = next(state.pending_blasts);
	if (firstPendingBlastId === undefined) {
		return;
	}

	const dueBlastIds: number[] = [];
	for (const [blastId, blast] of pairs(state.pending_blasts)) {
		if (!blast) {
			continue;
		}

		if (event.tick >= blast.flame_cleanup_tick) {
			dueBlastIds.push(blastId);
		}
	}

	for (const blastId of dueBlastIds) {
		const blast = state.pending_blasts[blastId];
		if (blast) {
			cleanupBlastFlame(blast);
			state.pending_blasts[blastId] = undefined;
		}
	}
}

init();
