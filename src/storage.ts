import { MapPosition } from 'factorio:runtime';
import { ShipModuleId } from './modules/ship/constants';

declare global {
	const storage: {
		hubRepaired: boolean;
		startupSuppliesSeeded: boolean;
		startConfiguredPlayerIndices: Record<number, true | undefined>;
		ship: {
			surface: string;
			modules: {
				[K in ShipModuleId]?: {
					position: MapPosition;
					direction: defines.direction;
					connectors: Array<{
						position: MapPosition;
						module: ShipModuleId;
						size: number;
					}>;
				};
			};
		};
	};
}

export function initStorage() {
	storage.hubRepaired ??= false;
	storage.startupSuppliesSeeded ??= false;
	storage.startConfiguredPlayerIndices ||= {};
	storage.ship ??= {
		surface: 'nauvis',
		modules: {
			hub: {
				position: { x: 0, y: 0 },
				direction: defines.direction.north,
				connectors: [],
			},
		},
	};
}

export function getCurrentSurface(surfaceName = storage.ship.surface) {
	const surface = game.surfaces[surfaceName];
	if (!surface) throw new Error(`Missing surface '${surfaceName}'.`);
	return surface;
}
