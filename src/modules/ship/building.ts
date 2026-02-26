import type { LuaEntity, MapPosition, TileWrite } from 'factorio:runtime';
import { createEntity, getCurrentSurface, on_event, registerGlobal } from '@/lib/utils';
import { names, shipModules } from './constants';

type ShipModuleId = keyof typeof shipModules;
type ShipConnectorOrientation = 'horizontal' | 'vertical';
type ShipConnector = {
	position: MapPosition;
	orientation: ShipConnectorOrientation;
	module?: ShipModuleId;
	moduleConnector?: number;
};
type ShipLayoutModule = {
	connectors: ShipConnector[];
};
type ModuleTemplate = {
	tiles: Array<{
		x: number;
		y: number;
	}>;
	tileKeys: Record<string, true | undefined>;
};

const hubCenter = { x: 0, y: 0 } as const;
const moduleTemplateCache: Partial<Record<ShipModuleId, ModuleTemplate>> = {};

on_event('on_built_entity', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	handleConnectorBuilt(event.entity, event.player_index);
});
on_event('on_robot_built_entity', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	handleConnectorBuilt(event.entity);
});
on_event('script_raised_built', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	handleConnectorBuilt(event.entity);
});
on_event('script_raised_revive', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	handleConnectorBuilt(event.entity);
});
on_event('on_player_mined_entity', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	removeConnectorFromLayout(event.entity);
});
on_event('on_robot_mined_entity', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	removeConnectorFromLayout(event.entity);
});
on_event('on_entity_died', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	removeConnectorFromLayout(event.entity);
});
on_event('script_raised_destroy', event => {
	if (!event.entity?.valid || event.entity.name !== names.connector) return;
	removeConnectorFromLayout(event.entity);
});

export function ensureInitialShipLayout() {
	storage.shipLayout ||= {};

	for (const moduleId of Object.keys(shipModules) as ShipModuleId[]) {
		if (storage.shipLayout[moduleId]) continue;
		const moduleConnectors = shipModules[moduleId].connectors ?? [];

		storage.shipLayout[moduleId] = {
			connectors: moduleConnectors.map(connector => ({
				orientation: connector.orientation,
				position: {
					x: connector.position.x,
					y: connector.position.y,
				},
			})),
		};
	}
}

export function ensureInitialShipModule(surface = getCurrentSurface()) {
	ensureInitialShipLayout();

	for (const moduleId of Object.keys(storage.shipLayout) as ShipModuleId[]) {
		if (moduleId !== 'hub') continue;
		const layout = storage.shipLayout[moduleId] as ShipLayoutModule | undefined;
		if (!layout) continue;
		const template = requireModuleTemplate(moduleId);
		const tiles: TileWrite[] = [];

		for (const tile of template.tiles)
			tiles.push({
				name: names.tile,
				position: {
					x: hubCenter.x + tile.x,
					y: hubCenter.y + tile.y,
				},
			});
		surface.set_tiles(tiles, true, false);

		for (const connector of layout.connectors) {
			const topLeft = { x: hubCenter.x + connector.position.x, y: hubCenter.y + connector.position.y };
			const connectorPosition = connectorEntityPosition(topLeft, connector.orientation);
			const existing = surface.find_entity(names.connector, connectorPosition);
			if (existing?.valid) continue;

			createEntity(surface, {
				name: names.connector,
				position: connectorPosition,
				direction: connectorDirection(connector.orientation),
			});
		}
	}
}

function handleConnectorBuilt(entity: LuaEntity, playerIndex?: number) {
	ensureInitialShipLayout();
	const placement = readConnectorPlacement(entity);
	if (!placement) return rejectConnector(entity, playerIndex);

	for (const moduleId of Object.keys(storage.shipLayout) as ShipModuleId[]) {
		const layout = storage.shipLayout[moduleId] as ShipLayoutModule | undefined;
		if (!layout) continue;
		if (moduleId !== 'hub') continue;
		if (!connectorInsideModule(moduleId, hubCenter, placement)) continue;
		if (!connectorOnEdge(moduleId, hubCenter, placement)) return rejectConnector(entity, playerIndex);
		if (connectorOverlaps(layout, hubCenter, placement)) return rejectConnector(entity, playerIndex);

		layout.connectors.push({
			orientation: placement.orientation,
			position: {
				x: placement.topLeft.x - hubCenter.x,
				y: placement.topLeft.y - hubCenter.y,
			},
		});
		return;
	}

	rejectConnector(entity, playerIndex);
}

function rejectConnector(entity: LuaEntity, playerIndex?: number) {
	const { force, position, surface } = entity;
	if (playerIndex !== undefined) {
		const player = game.players[playerIndex];
		if (player && player.surface.index === surface.index)
			player.create_local_flying_text({
				position,
				surface,
				text: 'can only be placed on the edge of a module',
			});
	} else
		for (const player of game.connected_players) {
			if (player.surface.index !== surface.index) continue;
			player.create_local_flying_text({
				position,
				surface,
				text: 'can only be placed on the edge of a module',
			});
		}

	entity.destroy();
	surface.spill_item_stack({
		allow_belts: false,
		drop_full_stack: false,
		enable_looted: true,
		force,
		position,
		stack: {
			count: 1,
			name: names.connector,
		},
	});
}

function readConnectorPlacement(entity: LuaEntity) {
	const orientation: ShipConnectorOrientation =
		entity.direction === defines.direction.east || entity.direction === defines.direction.west
			? 'vertical'
			: 'horizontal';
	const topLeft =
		orientation === 'horizontal'
			? {
					x: math.floor(entity.position.x - 1 + 0.001),
					y: math.floor(entity.position.y - 0.5 + 0.001),
				}
			: {
					x: math.floor(entity.position.x - 0.5 + 0.001),
					y: math.floor(entity.position.y - 1 + 0.001),
				};

	return {
		tiles: connectorToTiles(topLeft, orientation),
		topLeft,
		orientation,
	};
}

function connectorInsideModule(
	moduleId: ShipModuleId,
	center: MapPosition,
	placement: {
		tiles: Array<{ x: number; y: number }>;
	},
) {
	const template = requireModuleTemplate(moduleId);
	for (const tile of placement.tiles) {
		const relative = {
			x: tile.x - center.x,
			y: tile.y - center.y,
		};
		if (!template.tileKeys[tileKey(relative.x, relative.y)]) return false;
	}

	return true;
}

function connectorOnEdge(
	moduleId: ShipModuleId,
	center: MapPosition,
	placement: {
		orientation: ShipConnectorOrientation;
		tiles: Array<{ x: number; y: number }>;
	},
) {
	const template = requireModuleTemplate(moduleId);
	const hasTile = (x: number, y: number) => template.tileKeys[tileKey(x, y)] === true;
	const relativeTiles = placement.tiles.map(tile => ({
		x: tile.x - center.x,
		y: tile.y - center.y,
	}));

	if (placement.orientation === 'horizontal') {
		const northOpen = relativeTiles.every(tile => !hasTile(tile.x, tile.y - 1));
		const southOpen = relativeTiles.every(tile => !hasTile(tile.x, tile.y + 1));
		return northOpen || southOpen;
	}

	const westOpen = relativeTiles.every(tile => !hasTile(tile.x - 1, tile.y));
	const eastOpen = relativeTiles.every(tile => !hasTile(tile.x + 1, tile.y));
	return westOpen || eastOpen;
}

function connectorOverlaps(
	layout: ShipLayoutModule,
	center: MapPosition,
	placement: {
		tiles: Array<{ x: number; y: number }>;
	},
) {
	const occupied: Record<string, true | undefined> = {};
	for (const connector of layout.connectors) {
		const topLeft = {
			x: center.x + connector.position.x,
			y: center.y + connector.position.y,
		};
		for (const tile of connectorToTiles(topLeft, connector.orientation)) occupied[tileKey(tile.x, tile.y)] = true;
	}

	for (const tile of placement.tiles) if (occupied[tileKey(tile.x, tile.y)]) return true;
	return false;
}

function requireModuleTemplate(moduleId: ShipModuleId) {
	const cached = moduleTemplateCache[moduleId];
	if (cached) return cached;

	const blueprintTiles = readModuleBlueprintTiles(shipModules[moduleId].blueprint);
	let minX = blueprintTiles[0]!.x;
	let maxX = blueprintTiles[0]!.x;
	let minY = blueprintTiles[0]!.y;
	let maxY = blueprintTiles[0]!.y;
	for (const tile of blueprintTiles) {
		if (tile.x < minX) minX = tile.x;
		if (tile.x > maxX) maxX = tile.x;
		if (tile.y < minY) minY = tile.y;
		if (tile.y > maxY) maxY = tile.y;
	}

	const center = {
		x: math.ceil((minX + maxX) / 2),
		y: math.ceil((minY + maxY) / 2),
	};
	const template: ModuleTemplate = {
		tiles: [],
		tileKeys: {},
	};
	for (const tile of blueprintTiles) {
		const normalized = {
			x: tile.x - center.x,
			y: tile.y - center.y,
		};
		const key = tileKey(normalized.x, normalized.y);
		if (template.tileKeys[key]) continue;

		template.tileKeys[key] = true;
		template.tiles.push(normalized);
	}

	moduleTemplateCache[moduleId] = template;
	return template;
}

function readModuleBlueprintTiles(blueprintString: string) {
	let decoded = helpers.decode_string(blueprintString);
	if (!decoded && blueprintString.startsWith('0')) decoded = helpers.decode_string(blueprintString.slice(1));
	if (!decoded) throw new Error('Failed to decode ship module blueprint string.');

	const parsed = helpers.json_to_table(decoded) as
		| {
				blueprint?: {
					tiles?: Array<{
						position: {
							x: number;
							y: number;
						};
					}>;
				};
		  }
		| undefined;
	const blueprintTiles = parsed?.blueprint?.tiles;
	if (!blueprintTiles || blueprintTiles.length === 0)
		throw new Error('Ship module blueprint does not contain any tiles.');

	return blueprintTiles.map(tile => ({
		x: tile.position.x,
		y: tile.position.y,
	}));
}

function connectorToTiles(topLeft: MapPosition, orientation: ShipConnectorOrientation) {
	if (orientation === 'horizontal')
		return [
			{ x: topLeft.x, y: topLeft.y },
			{ x: topLeft.x + 1, y: topLeft.y },
		];

	return [
		{ x: topLeft.x, y: topLeft.y },
		{ x: topLeft.x, y: topLeft.y + 1 },
	];
}

function tileKey(x: number, y: number) {
	return `${x},${y}`;
}

function connectorDirection(orientation: ShipConnectorOrientation) {
	return orientation === 'horizontal' ? defines.direction.north : defines.direction.east;
}

function connectorEntityPosition(topLeft: MapPosition, orientation: ShipConnectorOrientation) {
	return orientation === 'horizontal'
		? { x: topLeft.x + 1, y: topLeft.y + 0.5 }
		: { x: topLeft.x + 0.5, y: topLeft.y + 1 };
}

function removeConnectorFromLayout(entity: LuaEntity) {
	const placement = readConnectorPlacement(entity);
	if (!placement) return;

	for (const moduleId of Object.keys(storage.shipLayout) as ShipModuleId[]) {
		const layout = storage.shipLayout[moduleId] as ShipLayoutModule | undefined;
		if (!layout) continue;
		if (moduleId !== 'hub') continue;

		const relativeTopLeft = {
			x: placement.topLeft.x - hubCenter.x,
			y: placement.topLeft.y - hubCenter.y,
		};
		const index = layout.connectors.findIndex(
			connector =>
				connector.orientation === placement.orientation &&
				connector.position.x === relativeTopLeft.x &&
				connector.position.y === relativeTopLeft.y,
		);
		if (index < 0) continue;
		layout.connectors.splice(index, 1);
		return;
	}
}

registerGlobal('ensureInitialShipLayout', ensureInitialShipLayout);
registerGlobal('ensureInitialShipModule', ensureInitialShipModule);
