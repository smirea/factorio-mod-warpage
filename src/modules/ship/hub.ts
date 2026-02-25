import { createEntity, createHolographicText, registerGlobal } from '@/lib/utils';
import type { CargoLandingPadEntity, LuaEntity, MapPositionArray } from 'factorio:runtime';
import { names } from './constants';

const hubClearRadius = 4;
const repairRequirements: Array<[string, number]> = [
	['stone', 200],
	['coal', 200],
	['copper-ore', 100],
	['iron-plate', 100],
	['calcite', 10],
];

registerGlobal('createHub', createHub);
registerGlobal('createDestroyedHub', createDestroyedHub);

function createHub() {
	const surface = getCurrentSurface();
	const landingPad = createEntity<CargoLandingPadEntity>(surface, {
		name: names.hubLandingPad,
		position: names.hubPosition,
	});

	createEntity(surface, { name: names.hubAccumulator, position: landingPad.position });
	createEntity(surface, { name: names.hubPowerPole, position: landingPad.position });
	createEntity(surface, {
		name: names.hubFluidPipe,
		position: relativeTo(names.hubFluidPipe, landingPad, 'right', 'bottom'),
	});
	createEntity(surface, {
		name: names.hubFluidPipe,
		position: relativeTo(names.hubFluidPipe, landingPad, 'left', 'bottom'),
	});
}

function createDestroyedHub(surface = getCurrentSurface()) {
	const { x, y } = names.hubPosition;
	for (const entity of surface.find_entities_filtered({
		area: [
			[x - hubClearRadius, y - hubClearRadius],
			[x + hubClearRadius, y + hubClearRadius],
		],
	})) {
		if (entity.valid) {
			entity.destroy();
		}
	}

	const hub = createEntity(surface, {
		name: names.destroyedHubContainer,
		position: names.hubPosition,
	});
	const inventory = hub.get_inventory(defines.inventory.chest);
	if (!inventory) {
		throw new Error('Missing destroyed hub container inventory.');
	}

	let slotIndex = 1;
	for (const [itemName, amount] of repairRequirements) {
		const stackSize = prototypes.item[itemName]?.stack_size;
		if (!stackSize || stackSize < 1) {
			throw new Error(`Missing stack size for repair requirement item '${itemName}'.`);
		}
		for (let index = 0; index < math.ceil(amount / stackSize); index += 1) {
			inventory.set_filter(slotIndex, itemName);
			slotIndex += 1;
		}
	}
	inventory.set_bar(slotIndex);

	const parts: string[] = [];
	for (const [itemName, amount] of repairRequirements) {
		let current = 0;
		for (const [, count] of pairs(inventory.get_item_quality_counts(itemName) as Record<string, number | undefined>)) {
			current += count ?? 0;
		}
		const remaining = math.max(0, amount - current);
		if (remaining > 0) {
			parts.push(`[item=${itemName}] ${remaining}`);
		}
	}

	createHolographicText({
		target: hub,
		text: parts.join(' '),
		ticks: 2e9,
		offset: { x: 0, y: -1 * hub.tile_height - 0.5 },
	});
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
		case 'top':
			if (origin === 'edge') finalY += height / 2;
			finalY -= targetHeight / 2;
			break;
		case 'bottom':
			if (origin === 'edge') finalY -= height / 2;
			finalY += targetHeight / 2;
			break;
		case 'middle':
			break;
	}

	switch (rX) {
		case 'left':
			if (origin === 'edge') finalX += width / 2;
			finalX -= targetWidth / 2;
			break;
		case 'right':
			if (origin === 'edge') finalX -= width / 2;
			finalX += targetWidth / 2;
			break;
		case 'middle':
			break;
	}

	return [finalX, finalY];
}

function getCurrentSurface() {
	const surface = game.surfaces[storage.surface];
	if (!surface) throw new Error('Cannot find current surface, this should not be possible');
	return surface;
}
