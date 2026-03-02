import { MapPosition } from 'factorio:runtime';
import { ShipConnectorSize, ShipModuleId } from './modules/ship/constants';
import { ensureInitialShipLayout, refreshShipModuleUnlocks } from './modules/ship/building';

declare global {
	const storage: {
		surface: string;
		hubRepaired: boolean;
		shipModules: Record<
			ShipModuleId,
			{
				center: MapPosition;
				connectorUnitNumbers: number[];
				placed: boolean;
				rotation: defines.direction.north | defines.direction.east | defines.direction.south | defines.direction.west;
				unlocked: boolean;
			}
		>;
		shipConnectors: Record<
			string,
			{
				moduleId: ShipModuleId;
				orientation: 'vertical' | 'horizontal';
				size: ShipConnectorSize;
				side: 'north' | 'east' | 'south' | 'west';
				topLeft: MapPosition;
			}
		>;
		shipConnectorStock: Record<
			ShipConnectorSize,
			{
				available: number;
				total: number;
				unlocked: boolean;
			}
		>;
		shipBridges: Record<
			string,
			{
				connectorUnitNumber: number;
				targetConnectorUnitNumber?: number;
				tiles: MapPosition[];
			}
		>;
		shipPlacementByPlayer: Record<
			number,
			| {
					kind: 'module';
					mode: 'move' | 'place';
					moduleId: ShipModuleId;
					renderIds: number[];
			  }
			| {
					connectorSize: ShipConnectorSize;
					kind: 'connector';
					renderIds: number[];
			  }
			| undefined
		>;
		startupSuppliesSeeded: boolean;
		startConfiguredPlayerIndices: Record<number, true | undefined>;
	};
}

export function initStorage() {
	storage.surface ||= 'nauvis';
	storage.hubRepaired ??= false;
	storage.startupSuppliesSeeded ??= false;
	storage.startConfiguredPlayerIndices ||= {};
	ensureInitialShipLayout();
	refreshShipModuleUnlocks();
}
