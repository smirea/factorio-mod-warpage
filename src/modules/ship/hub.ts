import { createEntity, registerGlobal } from '@/lib/utils';
import type { CargoLandingPadEntity, LuaEntity, MapPositionArray } from 'factorio:runtime';
import { names } from './constants';

registerGlobal('createHub', createHub);

function createHub() {
	const surface = getCurrentSurface();
	const landingPad = createEntity<CargoLandingPadEntity>(surface, {
		name: names.hubLandingPad,
		position: [0, 0],
	});
	const accumulator = createEntity(surface, {
		name: names.hubAccumulator,
		position: relativeTo(names.hubAccumulator, landingPad, 'bottom', 0, 'right', 0),
	});
	const powerPole = createEntity(surface, {
		name: names.hubPowerPole,
		position: relativeTo(names.hubPowerPole, landingPad, 'middle', 0, 'middle', 0),
	});
}

function relativeTo(
	sourceEntityName: string,
	target: Pick<LuaEntity, 'tile_width' | 'tile_height' | 'position'>,
	rY: 'top' | 'middle' | 'bottom',
	oY: number,
	rX: 'left' | 'middle' | 'right',
	oX: number,
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
			if (origin === 'edge') finalY += finalY + height / 2;
			finalY -= targetHeight / 2;
			break;
		case 'bottom':
			if (origin === 'edge') finalY -= finalY + height / 2;
			finalY += targetHeight / 2;
			break;
		case 'middle':
			break; // noop
	}

	switch (rX) {
		case 'left':
			if (origin === 'edge') finalX += finalX + width / 2;
			finalX -= targetWidth / 2;
			break;
		case 'right':
			if (origin === 'edge') finalX -= finalX + width / 2;
			finalX += targetWidth / 2;
			break;
		case 'middle':
			break; // noop
	}

	return [finalX, finalY];
}

function getCurrentSurface() {
	const surface = game.surfaces[storage.surface];
	if (!surface) throw new Error('Cannot find current surface, this should not be possible');
	return surface;
}
