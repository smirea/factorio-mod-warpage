import type {
	BoundingBox,
	LuaForce,
	LuaPlayer,
	LuaSurface,
	MapPosition,
	OnScriptTriggerEffectEvent,
} from 'factorio:runtime';
import { names } from './constants';
import { createEntity, on_event } from '@/lib/utils';

const RADIUS_TECHNOLOGY_NAMES = [1, 2, 3].map(level => names.ns('mining-radius-' + level));
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
	on_event('on_research_finished', on_research_finished);
}

const oreYieldFormula = (removedAmount: number, productivityMultiplier: number, oreMultiplier: number) =>
	math.ceil(math.max(5, math.min(removedAmount / 100, 25)) * productivityMultiplier * oreMultiplier);

function spillItemInStacks(
	surface: LuaSurface,
	force: LuaForce,
	position: MapPosition,
	itemName: string,
	itemCount: number,
) {
	if (itemCount < 1) throw new Error(`Thermite item spill count for '${itemName}' must be at least 1.`);

	let remaining = itemCount;
	while (remaining > 0) {
		const stackCount = math.min(remaining, 500);
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
		if (!resource.valid) continue;

		const resourcePrototype = prototypes.entity[resource.name];
		if (!resourcePrototype || resourcePrototype.resource_category !== 'basic-solid') continue;

		const amount = resource.amount;
		if (amount > 0) removedByItem[resource.name] = (removedByItem[resource.name] ?? 0) + amount;

		const destroyed = resource.destroy();
		if (destroyed !== true && resource.valid)
			throw new Error(`Failed to remove ore resource '${resource.name}' at thermite blast position.`);
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
		if (!removedAmount || removedAmount <= 0) continue;

		const oreMultiplier = (ORE_MULTIPLIER_BY_ITEM_NAME as Partial<Record<string, number>>)[itemName] ?? 0.5;
		const yieldCount = oreYieldFormula(removedAmount, productivityMultiplier, oreMultiplier);
		if (yieldCount < 1) throw new Error(`Thermite ore yield for item '${itemName}' must be at least 1.`);

		spillItemInStacks(surface, force, position, itemName, yieldCount);
	}
}

function resolveMineableProductAmount(product: any) {
	const probability = product.probability ?? 1;
	if (probability <= 0 || math.random() > probability) return 0;

	if (product.amount !== undefined) return product.amount;

	if (product.amount_min !== undefined && product.amount_max !== undefined)
		return math.random(product.amount_min, product.amount_max);

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
		if (products)
			for (const product of products) {
				const productType = product.type ?? 'item';
				if (productType !== 'item' || !product.name) continue;

				const minedAmount = resolveMineableProductAmount(product);
				const dropCount = math.floor(minedAmount * 0.5);
				if (dropCount > 0) spillItemInStacks(surface, force, entity.position, product.name, dropCount);
			}

		const destroyed = entity.destroy();
		if (destroyed !== true && entity.valid)
			throw new Error(`Failed to remove rock entity '${entity.name}' at thermite blast position.`);
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
		createEntity(surface, {
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

	for (let x = minX; x <= maxX; x += 1)
		for (let y = minY; y <= maxY; y += 1) {
			const dx = x + 0.5 - center.x;
			const dy = y + 0.5 - center.y;
			if (dx * dx + dy * dy > radius * radius) continue;

			createEntity(surface, {
				name: 'fire-flame',
				position: { x: x + 0.5, y: y + 0.5 },
			});
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
	const surface = game.surfaces[surface_index];
	if (!surface) throw new Error(`Missing surface index '${surface_index}'.`);

	const force = game.forces[force_name];
	if (!force) throw new Error(`Missing force '${force_name}'.`);

	let researchedLevels = 0;
	for (const technologyName of RADIUS_TECHNOLOGY_NAMES) {
		const technology = force.technologies[technologyName];
		if (technology && technology.researched) researchedLevels += 1;
	}
	const blastSize = 3 + researchedLevels;
	const blastRadius = blastSize / 2;
	const productivityLevel = force.technologies[names.miningProductivityRecipe]!.level;
	const productivityMultiplier = productivityLevel;

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

	createEntity(surface, {
		name: 'grenade-explosion',
		position,
	});

	const removedByItem = removeOreResources(surface, blastArea);
	removeRocks(surface, blastArea, force);

	const calciteMinDrop = productivityLevel;
	const calciteMaxDrop = 5 + productivityLevel * 2;
	spillItemInStacks(surface, force, position, 'calcite', math.random(calciteMinDrop, calciteMaxDrop));
	dropOreYield(surface, force, position, removedByItem, productivityMultiplier);
}

function on_script_trigger_effect(event: OnScriptTriggerEffectEvent | undefined) {
	if (!event) return;
	if (event.effect_id !== names.projectile) return;

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

function on_research_finished(event: { research?: { name: string; force: LuaForce } } | undefined) {
	const research = event?.research;
	if (research?.name !== names.item) return;

	const dropPodsOnPlayer = (player: LuaPlayer, pods: 1 | 2 | 3, count: number) => {
		for (let i = 0; i < pods; ++i) {
			const pod = createEntity(player.surface, {
				name: 'cargo-pod',
				position: player.position,
				force: research.force,
			});
			pod.get_inventory(defines.inventory.cargo_unit)!.insert({
				name: names.item,
				count,
			});
			pod.cargo_pod_destination = {
				type: defines.cargo_destination.surface,
				surface: player.surface,
				position: player.position,
				land_at_exact_position: false,
			};
		}
	};

	if (game.players.length() === 1) dropPodsOnPlayer(game.players[1]!, 3, 2);
	else
		// there seems to be a limit of max 3 pods spawned at a time
		for (let i = 1; i <= 3; ++i) {
			if (!game.players[i]) continue;
			dropPodsOnPlayer(game.players[i]!, 1, 2);
		}

	game.print('psst, look up, check the hub');
}

init();
