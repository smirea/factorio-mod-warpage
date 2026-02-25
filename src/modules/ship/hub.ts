import { createEntity, createHolographicText, getCurrentSurface, on_nth_tick, registerGlobal } from '@/lib/utils';
import type {
	CargoLandingPadEntity,
	LuaEntity,
	LuaInventory,
	MapPositionArray,
	SpeechBubbleEntity,
} from 'factorio:runtime';
import { names } from './constants';
import { ensureInitialShipModule } from './building';

const hubClearRadius = 4;
const repairRequirements: Record<string, number> = {
	calcite: 10,
	coal: 200,
	'copper-ore': 100,
	'iron-plate': 100,
	stone: 200,
};
const entities = {
	destroyedHub: undefined as undefined | LuaEntity,
	hub: undefined as undefined | LuaEntity,
	repairSpeechBubble: undefined as undefined | SpeechBubbleEntity,
};

registerGlobal('createHub', createHub);
registerGlobal('createDestroyedHub', createDestroyedHub);

let cancelHubRepairCheck: null | (() => void) = null;
script.on_load(() => {
	if (storage.hubRepaired) {
		onHubRepaired();
	} else {
		startHubRepairChecks();
	}
});

function startHubRepairChecks() {
	cancelHubRepairCheck?.();
	cancelHubRepairCheck = on_nth_tick(60, handleHubRepairCheck);
}

export function createHub() {
	const surface = getCurrentSurface();
	ensureInitialShipModule(surface);
	const landingPad = createEntity<CargoLandingPadEntity>(surface, {
		name: names.hubLandingPad,
		position: [0, 0],
	});
	makeIndestructible(landingPad);

	entities.hub = createEntity(surface, { name: names.hubAccumulator, position: landingPad.position });
	makeIndestructible(entities.hub);

	const hubPowerPole = createEntity(surface, { name: names.hubPowerPole, position: landingPad.position });
	makeIndestructible(hubPowerPole);

	const rightFluidPipe = createEntity(surface, {
		name: names.hubFluidPipe,
		position: relativeTo(names.hubFluidPipe, landingPad, 'right', 'bottom'),
	});
	makeIndestructible(rightFluidPipe);

	const leftFluidPipe = createEntity(surface, {
		name: names.hubFluidPipe,
		position: relativeTo(names.hubFluidPipe, landingPad, 'left', 'bottom'),
	});
	makeIndestructible(leftFluidPipe);
}

export function createDestroyedHub(surface = getCurrentSurface()) {
	storage.hubRepaired = false;
	lastRepairText = '';
	destroyEntity(entities.repairSpeechBubble);
	entities.repairSpeechBubble = undefined;

	for (const entity of surface.find_entities_filtered({
		area: [
			[-1 * hubClearRadius, -1 * hubClearRadius],
			[hubClearRadius, hubClearRadius],
		],
	})) {
		if (!entity.valid) {
			continue;
		}
		if (entity.type === 'character') {
			continue;
		}
		entity.destroy();
	}

	entities.destroyedHub = createEntity(surface, {
		name: names.destroyedHub,
		position: [0, 0],
	});
	makeIndestructible(entities.destroyedHub);
	const inventory = entities.destroyedHub!.get_inventory(defines.inventory.chest)!;

	let slotIndex = 1;
	for (const [itemName, amount] of Object.entries(repairRequirements)) {
		const stackSize = prototypes.item[itemName]?.stack_size;
		if (!stackSize || stackSize < 1) {
			throw new Error(`Missing stack size for repair requirement item '${itemName}'.`);
		}
		for (let index = 0; index < math.ceil(amount / stackSize); index += 1) {
			if (slotIndex > inventory.length) {
				throw new Error('Destroyed hub inventory is too small for current repair requirements.');
			}
			inventory.set_filter(slotIndex, itemName);
			slotIndex += 1;
		}
	}
	const requiredSlots = slotIndex - 1;
	for (let i = requiredSlots + 1; i <= inventory.length; ++i) {
		inventory.set_filter(i, 'deconstruction-planner');
	}
	if (requiredSlots < inventory.length) {
		inventory.set_bar(requiredSlots + 1);
	} else {
		inventory.set_bar();
	}

	startHubRepairChecks();
}

let lastRepairText = '';
function handleHubRepairCheck() {
	const destroyedHub = getDestroyedHub();
	if (!destroyedHub) {
		lastRepairText = '';
		destroyEntity(entities.repairSpeechBubble);
		entities.repairSpeechBubble = undefined;
		return;
	}

	const inventory = destroyedHub.get_inventory(defines.inventory.chest);
	if (!inventory) {
		return;
	}

	const extra: Record<string, number> = {};
	const parts: string[] = [];
	for (const [name, required] of Object.entries(repairRequirements)) {
		const remaining = required - getTotalItemCount(inventory, name);
		if (remaining > 0) {
			parts.push(`[item=${name}] ${remaining}`);
		} else if (remaining < 0) {
			extra[name] = remaining * -1;
		}
	}

	if (parts.length > 0) {
		const text = parts.join(' ');
		if (text !== lastRepairText) {
			lastRepairText = text;
			destroyEntity(entities.repairSpeechBubble);
			entities.repairSpeechBubble = createHolographicText({
				offset: { x: 0, y: -1 * destroyedHub.tile_height - 0.5 },
				target: destroyedHub,
				text: parts.join(' '),
				ticks: 2e9,
			});
		}
	} else {
		onHubRepaired();
		createHub();
		for (const [name, count] of Object.entries(extra)) {
			getCurrentSurface().spill_item_stack({
				allow_belts: false,
				drop_full_stack: false,
				enable_looted: true,
				position: entities.hub!.position,
				stack: { count, name },
			});
		}
	}
}

function onHubRepaired() {
	storage.hubRepaired = true;
	destroyEntity(entities.destroyedHub);
	entities.destroyedHub = undefined;
	entities.hub = undefined;
	destroyEntity(entities.repairSpeechBubble);
	entities.repairSpeechBubble = undefined;
	cancelHubRepairCheck?.();
	cancelHubRepairCheck = null;
	lastRepairText = '';
}

function getDestroyedHub() {
	if (entities.destroyedHub?.valid) {
		return entities.destroyedHub;
	}
	entities.destroyedHub = getCurrentSurface().find_entity(names.destroyedHub, [0, 0]) ?? undefined;
	if (entities.destroyedHub?.valid) {
		makeIndestructible(entities.destroyedHub);
		return entities.destroyedHub;
	}
	entities.destroyedHub = undefined;
	return;
}

function getTotalItemCount(inventory: LuaInventory, itemName: string) {
	let total = 0;
	for (const count of Object.values(inventory.get_item_quality_counts(itemName))) {
		total += count;
	}
	return total;
}

function destroyEntity(entity: LuaEntity | SpeechBubbleEntity | undefined) {
	if (!entity?.valid) {
		return;
	}
	entity.destroy();
}

function makeIndestructible(entity: { valid: boolean; destructible: boolean } | undefined) {
	if (!entity?.valid) {
		return;
	}
	entity.destructible = false;
}

function relativeTo(
	sourceEntityName: string,
	target: Pick<LuaEntity, 'tile_width' | 'tile_height' | 'position'>,
	rX: 'left' | 'middle' | 'right',
	rY: 'top' | 'middle' | 'bottom',
	oX = 0,
	oY = 0,
	origin: 'center' | 'edge' = 'edge',
): MapPositionArray {
	const sourceEntity = (prototypes.entity as any)[sourceEntityName] as LuaEntity;
	const width = sourceEntity.tile_width || 0;
	const height = sourceEntity.tile_height || 0;
	let finalY = oY + target.position.y;
	let finalX = oX + target.position.x;
	const targetWidth = target.tile_width;
	const targetHeight = target.tile_height;

	switch (rY) {
		case 'top': {
			if (origin === 'edge') {
				finalY += height / 2;
			}
			finalY -= targetHeight / 2;
			break;
		}
		case 'bottom': {
			if (origin === 'edge') {
				finalY -= height / 2;
			}
			finalY += targetHeight / 2;
			break;
		}
		case 'middle': {
			break;
		}
	}

	switch (rX) {
		case 'left': {
			if (origin === 'edge') {
				finalX += width / 2;
			}
			finalX -= targetWidth / 2;
			break;
		}
		case 'right': {
			if (origin === 'edge') {
				finalX -= width / 2;
			}
			finalX += targetWidth / 2;
			break;
		}
		case 'middle': {
			break;
		}
	}

	return [finalX, finalY];
}
