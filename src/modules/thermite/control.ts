import type { BoundingBox, LuaForce, LuaSurface, MapPosition, OnScriptTriggerEffectEvent } from 'factorio:runtime';
import { names } from './constants';
import { on_event } from '@/lib/utils';

const IMPACT_EFFECT_ID = names.projectile;

const PRODUCTIVITY_TECHNOLOGY_NAMES = [1, 2, 3, 4, 5].map(level => names.ns('mining-productivity-' + level));
const RADIUS_TECHNOLOGY_NAMES = [1, 2, 3].map(level => names.ns('mining-radius-' + level));

const BASE_BLAST_SIZE = 3;
const BASE_PRODUCTIVITY_MULTIPLIER = 1;
const ROCK_DROP_MULTIPLIER = 0.5;
const BASE_CALCITE_MIN_DROP = 1;
const BASE_CALCITE_MAX_DROP = 5;
const CALCITE_MIN_DROP_PER_PRODUCTIVITY_LEVEL = 1;
const CALCITE_MAX_DROP_PER_PRODUCTIVITY_LEVEL = 2;

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

function resolveMineableProductAmount(product: any) {
	const probability = product.probability ?? 1;
	if (probability <= 0 || math.random() > probability) return 0;

	if (product.amount !== undefined) {
		return product.amount;
	}

	if (product.amount_min !== undefined && product.amount_max !== undefined) {
		return math.random(product.amount_min, product.amount_max);
	}

	return 0;
}

function removeRocks(surface: LuaSurface, area: BoundingBox, force: LuaForce) {
	const entities = surface.find_entities_filtered({
		area,
		type: 'simple-entity',
	});

	for (const entity of entities) {
		if (!entity.valid || !entity.name.includes('rock')) continue;

		const products = prototypes.entity[entity.name]?.mineable_properties?.products;
		if (products) {
			for (const product of products) {
				const productType = product.type ?? 'item';
				if (productType !== 'item' || !product.name) continue;

				const minedAmount = resolveMineableProductAmount(product);
				const dropCount = math.floor(minedAmount * ROCK_DROP_MULTIPLIER);
				if (dropCount > 0) {
					spillItemInStacks(surface, force, entity.position, product.name, dropCount);
				}
			}
		}

		const destroyed = entity.destroy();
		if (destroyed !== true && entity.valid) {
			throw new Error(`Failed to remove rock entity '${entity.name}' at thermite blast position.`);
		}
	}
}

function igniteTrees(surface: LuaSurface, area: BoundingBox) {
	const treeFlameName = prototypes.entity['fire-flame-on-tree'] ? 'fire-flame-on-tree' : 'fire-flame';
	const trees = surface.find_entities_filtered({
		area,
		type: 'tree',
	});

	for (const tree of trees) {
		if (!tree.valid) continue;
		surface.create_entity({
			name: treeFlameName,
			position: tree.position,
		});
	}
}

function spawnBlastFlames(surface: LuaSurface, center: MapPosition, radius: number) {
	const minX = math.floor(center.x - radius);
	const maxX = math.ceil(center.x + radius);
	const minY = math.floor(center.y - radius);
	const maxY = math.ceil(center.y + radius);

	for (let x = minX; x <= maxX; x += 1) {
		for (let y = minY; y <= maxY; y += 1) {
			const dx = x + 0.5 - center.x;
			const dy = y + 0.5 - center.y;
			if (dx * dx + dy * dy > radius * radius) {
				continue;
			}

			surface.create_entity({
				name: 'fire-flame',
				position: { x: x + 0.5, y: y + 0.5 },
			});
		}
	}
}

function detonateBlast({
	surface_index,
	position,
	force_name,
}: {
	surface_index: number;
	position: MapPosition;
	force_name: string;
}) {
	const surface = requireSurfaceByIndex(surface_index);
	const force = requireForce(force_name);
	const blastSize = BASE_BLAST_SIZE + countResearchedLevels(force, RADIUS_TECHNOLOGY_NAMES);
	const blastRadius = blastSize / 2;
	const productivityLevel = countResearchedLevels(force, PRODUCTIVITY_TECHNOLOGY_NAMES);
	const productivityMultiplier = BASE_PRODUCTIVITY_MULTIPLIER + productivityLevel;

	const blastArea = {
		left_top: {
			x: position.x - blastRadius,
			y: position.y - blastRadius,
		},
		right_bottom: {
			x: position.x + blastRadius,
			y: position.y + blastRadius,
		},
	};

	spawnBlastFlames(surface, position, blastRadius);
	igniteTrees(surface, blastArea);

	surface.create_entity({
		name: 'grenade-explosion',
		position,
	});

	const removedByItem = removeOreResources(surface, blastArea);
	removeRocks(surface, blastArea, force);

	const calciteMinDrop = BASE_CALCITE_MIN_DROP + productivityLevel * CALCITE_MIN_DROP_PER_PRODUCTIVITY_LEVEL;
	const calciteMaxDrop = BASE_CALCITE_MAX_DROP + productivityLevel * CALCITE_MAX_DROP_PER_PRODUCTIVITY_LEVEL;
	spillItemInStacks(surface, force, position, 'calcite', math.random(calciteMinDrop, calciteMaxDrop));
	dropOreYield(surface, force, position, removedByItem, productivityMultiplier);
}

function on_script_trigger_effect(event: OnScriptTriggerEffectEvent | undefined) {
	if (!event) return;
	if (event.effect_id !== IMPACT_EFFECT_ID) return;

	const position = event.target_position ?? event.source_position;
	if (!position) return;

	const forceName =
		(event.source_entity?.valid && event.source_entity.force.name) ||
		(event.cause_entity?.valid && event.cause_entity.force.name) ||
		'player';

	detonateBlast({
		surface_index: event.surface_index,
		position,
		force_name: forceName,
	});
}

init();
