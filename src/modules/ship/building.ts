import type { TileWrite } from 'factorio:runtime';
import { getCurrentSurface, registerGlobal } from '@/lib/utils';
import { names } from './constants';

export function ensureInitialShipModule(surface = getCurrentSurface()) {
	const tiles: TileWrite[] = [];

	for (let x = -7; x <= 7; x += 1)
		for (let y = -7; y <= 7; y += 1)
			tiles.push({
				name: names.tile,
				position: { x, y },
			});

	surface.set_tiles(tiles, true, false);
}

registerGlobal('ensureInitialShipModule', ensureInitialShipModule);
