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
import { createHolographicText, on_event, on_nth_tick } from '@/utils';

const IMPACT_EFFECT_ID = names.projectile;
const TOOLTIP_ANCHOR_ENTITY_NAME = names.ns('tooltip-anchor');

const PRODUCTIVITY_TECHNOLOGY_NAMES = [1, 2, 3, 4, 5].map(level => names.ns('mining-productivity-' + level));
const RADIUS_TECHNOLOGY_NAMES = [1, 2, 3].map(level => names.ns('mining-radius-' + level));

const BASE_RADIUS = 2;
const BASE_PRODUCTIVITY_MULTIPLIER = 1;
const COUNTDOWN_TICKS = 60 * 3;
const RESCUE_COOLDOWN_TICKS = 60 * 60 * 10;

const ORE_DROP_STACK_SIZE = 500;
const ORE_DEFAULT_MULTIPLIER = 0.5;
const ORE_MULTIPLIER_BY_ITEM_NAME: Record<string, number | undefined> = {
	'iron-ore': 1,
	'copper-ore': 1,
	coal: 0.75,
	stone: 0.5,
	calcite: 0.4,
	'tungsten-ore': 0.2,
	scrap: 1,
};

const THERMITE_COUNTDOWN_TOOLTIP_LIFETIME = 70;
const THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME = 100;
const THERMITE_COUNTDOWN_TOOLTIP_OFFSET: MapPosition = { x: 0, y: -2.6 };
const THERMITE_EMPTY_BLAST_TOOLTIP_OFFSET: MapPosition = { x: 0, y: -1.5 };

let countdownSecondsByBlastId: Record<number, number | undefined> = {};

function init() {
	script.on_load(() => {
		countdownSecondsByBlastId = {};
	});

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
	return surface as LuaSurface;
};

const requireForce = (name: string): LuaForce => {
	const force = game.forces[name];
	if (!force) throw new Error(`Missing force '${name}'.`);
	return force as LuaForce;
};

function ensureThermiteState(): ThermiteMiningState {
	let state = storage.thermite_mining;
	if (!state) {
		state = {
			next_blast_id: 1,
			pending_blasts: {},
			tooltip_anchor_cleanup_ticks: {},
			unlock_bonus_delivered: false,
		};
		storage.thermite_mining = state;
	}

	if (!state.tooltip_anchor_cleanup_ticks) {
		state.tooltip_anchor_cleanup_ticks = {};
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

const computeProductivityMultiplier = (force: LuaForce) =>
	BASE_PRODUCTIVITY_MULTIPLIER + countResearchedLevels(force, PRODUCTIVITY_TECHNOLOGY_NAMES);

const computeBlastRadius = (force: LuaForce) => BASE_RADIUS + countResearchedLevels(force, RADIUS_TECHNOLOGY_NAMES);

const oreYieldFormula = (removedAmount: number, productivityMultiplier: number, oreMultiplier: number) =>
	math.ceil(math.max(5, math.min(removedAmount / 100, 25)) * productivityMultiplier * oreMultiplier);

const resolveOreMultiplier = (itemName: string) => ORE_MULTIPLIER_BY_ITEM_NAME[itemName] ?? ORE_DEFAULT_MULTIPLIER;

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

function resolveBlastAreaAndCenter(position: MapPosition, radius: number): [BoundingBox, MapPosition] {
	const leftTopX = position.x - radius;
	const leftTopY = position.y - radius;
	const rightBottomX = position.x + radius;
	const rightBottomY = position.y + radius;

	return [
		{
			left_top: { x: leftTopX, y: leftTopY },
			right_bottom: { x: rightBottomX, y: rightBottomY },
		},
		{
			x: (leftTopX + rightBottomX) / 2,
			y: (leftTopY + rightBottomY) / 2,
		},
	];
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
	let removedAny = false;
	for (const [itemName, removedAmount] of pairs(removedByItem)) {
		if (!removedAmount || removedAmount <= 0) {
			continue;
		}
		removedAny = true;
		const oreMultiplier = resolveOreMultiplier(itemName);
		const yieldCount = oreYieldFormula(removedAmount, productivityMultiplier, oreMultiplier);
		if (yieldCount < 1) {
			throw new Error(`Thermite ore yield for item '${itemName}' must be at least 1.`);
		}
		spillItemInStacks(surface, force, position, itemName, yieldCount);
	}
	return removedAny;
}

function cleanupBlastFlame(blast: ThermiteQueuedBlast) {
	if (blast.flame_unit_number === undefined) return;
	const flame = game.get_entity_by_unit_number(blast.flame_unit_number as UnitNumber);
	if (!flame || !flame.valid) return;
	flame.destroy();
}

function scheduleBlastTooltipAnchorCleanup(state: ThermiteMiningState, blast: ThermiteQueuedBlast, tick: number) {
	if (blast.tooltip_anchor_unit_number === undefined) return;
	state.tooltip_anchor_cleanup_ticks[blast.tooltip_anchor_unit_number] = tick + THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME;
}

function resolveBlastTooltipAnchorEntity(blast: ThermiteQueuedBlast) {
	if (blast.tooltip_anchor_unit_number === undefined) return;
	const tooltipAnchor = game.get_entity_by_unit_number(blast.tooltip_anchor_unit_number as UnitNumber);
	if (!tooltipAnchor || !tooltipAnchor.valid) return;
	return tooltipAnchor;
}

function detonateBlast(state: ThermiteMiningState, blastId: number, blast: ThermiteQueuedBlast, tick: number) {
	const surface = requireSurfaceByIndex(blast.surface_index);
	const force = requireForce(blast.force_name);

	const radius = computeBlastRadius(force);
	const productivityMultiplier = computeProductivityMultiplier(force);
	const [blastArea, dropPosition] = resolveBlastAreaAndCenter(blast.position, radius);

	const calciteCount = math.random(1, 5) * productivityMultiplier;
	spillItemInStacks(surface, force, dropPosition, 'calcite', calciteCount);

	const removedByItem = removeOreResources(surface, blastArea);
	const removedAny = dropOreYield(surface, force, dropPosition, removedByItem, productivityMultiplier);

	surface.create_entity({
		name: 'grenade-explosion',
		position: blast.position,
	});

	if (!removedAny) {
		const tooltipAnchor = resolveBlastTooltipAnchorEntity(blast);
		if (tooltipAnchor) {
			createHolographicText({
				target: tooltipAnchor,
				text: 'x.x',
				offset: THERMITE_EMPTY_BLAST_TOOLTIP_OFFSET,
				ticks: THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME,
			});
		}
	}

	scheduleBlastTooltipAnchorCleanup(state, blast, tick);
	cleanupBlastFlame(blast);
	state.pending_blasts[blastId] = undefined;
	countdownSecondsByBlastId[blastId] = undefined;
}

function processTooltipAnchorCleanup(state: ThermiteMiningState, tick: number) {
	for (const [unitNumber, cleanupTick] of pairs(state.tooltip_anchor_cleanup_ticks)) {
		if (cleanupTick === undefined || tick < cleanupTick) {
			continue;
		}

		const tooltipAnchor = game.get_entity_by_unit_number(unitNumber as UnitNumber);
		if (tooltipAnchor && tooltipAnchor.valid) {
			const destroyed = tooltipAnchor.destroy();
			if (destroyed !== true && tooltipAnchor.valid) {
				throw new Error('Failed to destroy thermite tooltip anchor entity.');
			}
		}

		state.tooltip_anchor_cleanup_ticks[unitNumber] = undefined;
	}
}

function updateBlastCountdown(blastId: number, blast: ThermiteQueuedBlast, tick: number) {
	const remainingTicks = blast.trigger_tick - tick;
	if (remainingTicks <= 0) {
		return;
	}

	const secondsRemaining = math.ceil(remainingTicks / 60);
	if (secondsRemaining < 1 || secondsRemaining > 3) {
		return;
	}

	if (countdownSecondsByBlastId[blastId] === secondsRemaining) {
		return;
	}

	const surface = requireSurfaceByIndex(blast.surface_index);

	const tooltipAnchor = resolveBlastTooltipAnchorEntity(blast);
	if (!tooltipAnchor) {
		countdownSecondsByBlastId[blastId] = secondsRemaining;
		return;
	}

	if (tooltipAnchor.surface !== surface) {
		throw new Error(`Thermite tooltip anchor surface mismatch for blast id '${blast.id}'.`);
	}

	createHolographicText({
		target: tooltipAnchor,
		text: String(secondsRemaining),
		offset: THERMITE_COUNTDOWN_TOOLTIP_OFFSET,
		ticks: THERMITE_COUNTDOWN_TOOLTIP_LIFETIME,
	});
	countdownSecondsByBlastId[blastId] = secondsRemaining;
}

function on_script_trigger_effect(event: OnScriptTriggerEffectEvent) {
	if (event.effect_id !== IMPACT_EFFECT_ID) {
		return;
	}

	const position = event.target_position ?? event.source_position;
	if (!position) {
		return;
	}

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

	const tooltipAnchor = surface.create_entity({
		name: TOOLTIP_ANCHOR_ENTITY_NAME,
		position,
		force: sourceEntity.force,
	})!;

	tooltipAnchor.destructible = false;
	tooltipAnchor.minable = false;

	const blast: ThermiteQueuedBlast = {
		id: blastId,
		surface_index: event.surface_index,
		position,
		force_name: sourceEntity.force!.name,
		trigger_tick: event.tick + COUNTDOWN_TICKS,
	};

	if (flame && flame.unit_number !== undefined) {
		blast.flame_unit_number = flame.unit_number;
	}
	if (tooltipAnchor.unit_number !== undefined) {
		blast.tooltip_anchor_unit_number = tooltipAnchor.unit_number;
	}

	state.pending_blasts[blastId] = blast;
	countdownSecondsByBlastId[blastId] = 3;
	createHolographicText({
		target: tooltipAnchor,
		text: '3',
		offset: THERMITE_COUNTDOWN_TOOLTIP_OFFSET,
		ticks: THERMITE_COUNTDOWN_TOOLTIP_LIFETIME,
	});
}

function handleBlastUpdates(event: NthTickEventData) {
	const state = ensureThermiteState();
	processTooltipAnchorCleanup(state, event.tick);

	const [firstPendingBlastId] = next(state.pending_blasts);
	if (firstPendingBlastId === undefined) {
		return;
	}

	const dueBlastIds: number[] = [];
	for (const [blastId, blast] of pairs(state.pending_blasts)) {
		if (!blast) {
			continue;
		}

		if (event.tick >= blast.trigger_tick) {
			dueBlastIds.push(blastId);
		} else {
			updateBlastCountdown(blastId, blast, event.tick);
		}
	}

	for (const blastId of dueBlastIds) {
		const blast = state.pending_blasts[blastId];
		if (blast) {
			detonateBlast(state, blastId, blast, event.tick);
		}
	}
}

init();
