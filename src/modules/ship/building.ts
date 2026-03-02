import type { LocalisedString, LuaEntity, LuaPlayer, LuaSurface, MapPosition, TileWrite } from 'factorio:runtime';
import { createEntity, getCurrentSurface, on_event, on_nth_tick, registerGlobal } from '@/lib/utils';
import { names, ShipModuleId, shipModuleIds } from './constants';
import {
	ShipConnectorPlacement,
	ShipConnectorSide,
	ShipRotation,
	connectorDirection,
	connectorEntityPosition,
	connectorPlacementEdgeSide,
	connectorToTiles,
	moduleDefaultConnectorPlacements,
	moduleWorldBounds,
	moduleWorldTileKeys,
	moduleWorldTiles,
	normalizeRotation,
	oppositeSide,
	outwardVector,
	readConnectorPlacement,
	rotateConnectorTopLeftAroundCenter,
	rotateSide,
	rotationDelta,
	tileKey,
	translateConnectorPlacement,
} from './runtime';

const bridgeMaxRange = 6;
const rosterModuleIds = shipModuleIds.filter(
	(moduleId): moduleId is Exclude<ShipModuleId, 'hub'> => moduleId !== 'hub',
);
const placementCarrierItemNames = rosterModuleIds.map(moduleId => names.modulePlacementItem(moduleId));
const placementCarrierItems: Record<string, true | undefined> = {};
for (const itemName of placementCarrierItemNames) placementCarrierItems[itemName] = true;
type PlacementResult = { ok: true } | { ok: false; message: LocalisedString };

on_event('on_built_entity', event => {
	const entity = event.entity;
	if (!entity) return;

	const moduleId = moduleIdFromPlacementEntityName(entity.name);
	if (moduleId) {
		handlePlacementCarrierBuilt(entity, event.player_index, moduleId);
		return;
	}
	if (entity.name === names.connector) handleConnectorBuilt(entity, event.player_index);
});

on_event('on_robot_built_entity', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) handleConnectorBuilt(entity);
});

on_event('script_raised_built', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) handleConnectorBuilt(entity);
});

on_event('script_raised_revive', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) handleConnectorBuilt(entity);
});

on_event('on_player_mined_entity', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) removeConnectorFromLayout(entity);
});

on_event('on_robot_mined_entity', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) removeConnectorFromLayout(entity);
});

on_event('on_entity_died', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) removeConnectorFromLayout(entity);
});

on_event('script_raised_destroy', event => {
	const entity = event.entity;
	if (!entity) return;
	if (entity.name === names.connector) removeConnectorFromLayout(entity);
});

on_event('on_gui_click', event => {
	const player = game.players[event.player_index];
	const element = event.element;
	if (!player || !element) return;

	for (const moduleId of rosterModuleIds) {
		if (element.name !== names.moduleRosterButton(moduleId)) continue;
		const session = storage.shipPlacementByPlayer[player.index];
		if (session?.moduleId === moduleId) {
			clearPlacementSession(player.index);
			return;
		}
		startPlacementSession(player, moduleId);
		return;
	}
});

on_event('on_player_main_inventory_changed', event => {
	const player = game.players[event.player_index];
	if (!player) return;
	purgePlacementCarrierItems(player);
});

on_event('on_player_dropped_item', event => {
	const stack = event.entity.stack;
	if (!stack || !placementCarrierItems[stack.name]) return;
	event.entity.destroy();
});

on_event('on_player_cursor_stack_changed', event => {
	const session = storage.shipPlacementByPlayer[event.player_index];
	if (!session) return;

	const player = game.players[event.player_index];
	if (!player) return;
	const stack = player.cursor_stack;
	if (!stack || !stack.valid_for_read) {
		clearPlacementSession(player.index);
		return;
	}

	const cursorModuleId = moduleIdFromPlacementItemName(stack.name);
	if (!cursorModuleId || cursorModuleId !== session.moduleId) clearPlacementSession(player.index);
});

on_event('on_player_left_game', event => {
	clearPlacementSession(event.player_index);
});

on_event('on_player_removed', event => {
	clearPlacementSession(event.player_index);
});

on_event('on_player_joined_game', event => {
	const player = game.players[event.player_index];
	if (!player) return;
	ensureModuleRoster(player);
});

on_event('on_research_finished', event => {
	refreshShipModuleUnlocks(event.research.force);
	refreshAllShipModuleRosters();
});

on_nth_tick(30, () => {
	for (const player of game.connected_players) {
		const session = storage.shipPlacementByPlayer[player.index];
		if (!session) continue;
		refreshPlacementSessionRenders(player, session);
	}
});

export function ensureInitialShipLayout() {
	storage.shipModules ||= {} as ModStorage['shipModules'];
	storage.shipConnectors ||= {};
	storage.shipBridges ||= {};
	storage.shipPlacementByPlayer ||= {};

	for (const moduleId of shipModuleIds) {
		if (storage.shipModules[moduleId]) continue;
		storage.shipModules[moduleId] = {
			center: moduleId === 'hub' ? { x: 0, y: 0 } : { x: 0, y: 0 },
			connectorUnitNumbers: [],
			placed: moduleId === 'hub',
			rotation: defines.direction.north,
			unlocked: moduleId === 'hub',
		};
	}
}

export function refreshShipModuleUnlocks(force = game.forces.player!) {
	ensureInitialShipLayout();
	for (const moduleId of shipModuleIds) {
		const state = storage.shipModules[moduleId];
		if (moduleId === 'hub') {
			state.unlocked = true;
			continue;
		}
		state.unlocked = force.technologies[names.ns(`module-${moduleId}`)]?.researched === true;
	}
}

export function ensureInitialShipModule(surface = getCurrentSurface()) {
	ensureInitialShipLayout();
	refreshShipModuleUnlocks();
	const hub = storage.shipModules.hub;
	hub.placed = true;
	hub.center = { x: 0, y: 0 };
	hub.rotation = defines.direction.north;
	setTilesToShip(surface, moduleWorldTiles('hub', hub.center, hub.rotation));
	ensureModuleDefaultConnectors('hub', surface);
	recomputeBridges(surface);
}

export function ensureModuleRoster(player: LuaPlayer) {
	ensureInitialShipLayout();
	const parent = player.gui.left;
	let frame = parent[names.moduleRosterFrame];
	if (!frame)
		frame = parent.add({
			type: 'frame',
			name: names.moduleRosterFrame,
			direction: 'vertical',
			caption: ['warpage.module-roster-title'],
		});
	let flow = frame[names.moduleRosterFlow];
	if (!flow)
		flow = frame.add({
			type: 'flow',
			name: names.moduleRosterFlow,
			direction: 'vertical',
		});

	const hubRow = flow[names.ns('module-row-hub')];
	if (hubRow) hubRow.destroy();

	for (const moduleId of rosterModuleIds) {
		const rowName = names.ns(`module-row-${moduleId}`);
		let row = flow[rowName];
		if (!row)
			row = flow.add({
				type: 'flow',
				name: rowName,
				direction: 'horizontal',
			});

		if (!row[names.moduleRosterButton(moduleId)])
			row.add({
				type: 'sprite-button',
				name: names.moduleRosterButton(moduleId),
				sprite: names.moduleIconSprite(moduleId),
				style: 'slot_sized_button',
			});
		const labelName = names.ns(`module-label-${moduleId}`);
		if (!row[labelName])
			row.add({
				type: 'label',
				name: labelName,
				caption: moduleId,
			});
	}

	refreshModuleRoster(player);
}

export function refreshAllShipModuleRosters() {
	for (const [, player] of pairs(game.players)) {
		if (!player) continue;
		ensureModuleRoster(player);
	}
}

function refreshModuleRoster(player: LuaPlayer) {
	const frame = player.gui.left[names.moduleRosterFrame];
	if (!frame) return;
	const flow = frame[names.moduleRosterFlow];
	if (!flow) return;
	const session = storage.shipPlacementByPlayer[player.index];

	for (const moduleId of rosterModuleIds) {
		const row = flow[names.ns(`module-row-${moduleId}`)];
		if (!row) continue;
		const button = row[names.moduleRosterButton(moduleId)];
		const label = row[names.ns(`module-label-${moduleId}`)];
		if (!button || !label) continue;

		const state = storage.shipModules[moduleId];
		const statusText: LocalisedString = !state.unlocked
			? ['warpage.module-status-locked']
			: state.placed
				? ['warpage.module-status-placed']
				: ['warpage.module-status-unplaced'];
		const isSelected = session?.moduleId === moduleId;
		button.enabled = state.unlocked;
		button.style = isSelected ? 'slot_sized_button_pressed' : 'slot_sized_button';
		button.tooltip = ['warpage.module-button-tooltip', moduleId, statusText];
		label.caption = moduleId;
	}
}

function startPlacementSession(player: LuaPlayer, moduleId: ShipModuleId) {
	ensureInitialShipLayout();
	if (moduleId === 'hub') return;
	const module = storage.shipModules[moduleId];
	if (!module.unlocked) {
		showFlyingText(player, player.position, ['warpage.module-locked']);
		return;
	}

	clearPlacementSession(player.index);
	const mode = module.placed ? 'move' : 'place';
	storage.shipPlacementByPlayer[player.index] = {
		mode,
		moduleId,
		renderIds: [],
	};
	refreshModuleRoster(player);
	if (!givePlacementCarrier(player, moduleId)) {
		clearPlacementSession(player.index);
		showFlyingText(player, player.position, ['warpage.module-placement-cursor-blocked']);
		return;
	}

	showFlyingText(player, player.position, ['warpage.module-placement-selected', moduleId]);
	refreshPlacementSessionRenders(player, storage.shipPlacementByPlayer[player.index]!);
}

function givePlacementCarrier(player: LuaPlayer, moduleId: ShipModuleId) {
	if (!player.clear_cursor()) return false;
	const cursor = player.cursor_stack;
	if (!cursor) return false;
	cursor.set_stack({
		name: names.modulePlacementItem(moduleId),
		count: 1,
	});
	player.cursor_stack_temporary = true;
	return true;
}

function clearPlacementSession(playerIndex: number) {
	const session = storage.shipPlacementByPlayer[playerIndex];
	if (!session) return;
	destroyRenderIds(session.renderIds);
	storage.shipPlacementByPlayer[playerIndex] = undefined;
	const player = game.players[playerIndex];
	if (player) {
		purgePlacementCarrierItems(player);
		refreshModuleRoster(player);
	}
}

function refreshPlacementSessionRenders(
	player: LuaPlayer,
	session: {
		mode: 'move' | 'place';
		moduleId: ShipModuleId;
		renderIds: number[];
	},
) {
	destroyRenderIds(session.renderIds);
	session.renderIds = [];

	if (session.mode === 'move') {
		const module = storage.shipModules[session.moduleId];
		if (module.placed) {
			const bounds = moduleWorldBounds(session.moduleId, module.center, module.rotation);
			const rectangle = rendering.draw_rectangle({
				color: { r: 0.1, g: 0.8, b: 1, a: 0.2 },
				filled: true,
				left_top: { x: bounds.minX, y: bounds.minY },
				right_bottom: { x: bounds.maxX + 1, y: bounds.maxY + 1 },
				surface: player.surface,
				players: [player.index],
				draw_on_ground: true,
			});
			session.renderIds.push(rectangle.id as number);
		}
	}

	for (const connector of Object.values(storage.shipConnectors)) {
		if (!connector) continue;
		if (connector.moduleId === session.moduleId && session.mode === 'move') continue;
		const placement = {
			topLeft: connector.topLeft,
			orientation: connector.orientation,
			tiles: connectorToTiles(connector.topLeft, connector.orientation),
		};
		const outward = outwardVector(connector.side);
		const center =
			connector.orientation === 'horizontal'
				? { x: connector.topLeft.x + 1, y: connector.topLeft.y + 0.5 }
				: { x: connector.topLeft.x + 0.5, y: connector.topLeft.y + 1 };

		const marker = rendering.draw_rectangle({
			color: { r: 0.95, g: 0.65, b: 0.2, a: 0.9 },
			filled: true,
			left_top: { x: center.x - 0.15, y: center.y - 0.15 },
			right_bottom: { x: center.x + 0.15, y: center.y + 0.15 },
			surface: player.surface,
			players: [player.index],
			draw_on_ground: true,
		});
		session.renderIds.push(marker.id as number);

		const wantedSide = oppositeSide(connector.side);
		let previewPlacement: ShipConnectorPlacement | undefined;
		let previewIsExistingConnector = false;
		for (let step = 1; step <= bridgeMaxRange; step += 1) {
			const candidate = translateConnectorPlacement(placement, outward, step);
			const existing = findConnectorAtPlacement(candidate);
			if (existing) {
				if (existing.side === wantedSide) {
					previewPlacement = candidate;
					previewIsExistingConnector = true;
				}
				break;
			}
			const owner = findEdgeOwnerForConnector(candidate, wantedSide, connector.moduleId);
			if (owner) {
				previewPlacement = candidate;
				break;
			}
		}
		if (!previewPlacement) continue;

		const targetCenter =
			previewPlacement.orientation === 'horizontal'
				? { x: previewPlacement.topLeft.x + 1, y: previewPlacement.topLeft.y + 0.5 }
				: { x: previewPlacement.topLeft.x + 0.5, y: previewPlacement.topLeft.y + 1 };
		const previewLine = rendering.draw_line({
			from: center,
			to: targetCenter,
			surface: player.surface,
			players: [player.index],
			color: previewIsExistingConnector ? { r: 0.15, g: 0.95, b: 0.3, a: 0.95 } : { r: 0.25, g: 0.8, b: 1, a: 0.9 },
			width: 3,
			gap_length: previewIsExistingConnector ? 0 : 0.4,
			dash_length: previewIsExistingConnector ? 0 : 0.8,
			draw_on_ground: true,
		});
		session.renderIds.push(previewLine.id as number);

		const tileA = previewPlacement.tiles[0];
		const tileB = previewPlacement.tiles[1];
		const minX = tileA.x < tileB.x ? tileA.x : tileB.x;
		const minY = tileA.y < tileB.y ? tileA.y : tileB.y;
		const maxX = tileA.x > tileB.x ? tileA.x : tileB.x;
		const maxY = tileA.y > tileB.y ? tileA.y : tileB.y;
		const candidateArea = rendering.draw_rectangle({
			color: previewIsExistingConnector ? { r: 0.15, g: 0.95, b: 0.3, a: 0.2 } : { r: 0.25, g: 0.8, b: 1, a: 0.18 },
			filled: true,
			left_top: { x: minX, y: minY },
			right_bottom: { x: maxX + 1, y: maxY + 1 },
			surface: player.surface,
			players: [player.index],
			draw_on_ground: true,
		});
		session.renderIds.push(candidateArea.id as number);
	}
}

function destroyRenderIds(renderIds: number[]) {
	for (const renderId of renderIds) rendering.get_object_by_id(renderId)?.destroy();
	renderIds.length = 0;
}

function handlePlacementCarrierBuilt(entity: LuaEntity, playerIndex: number | undefined, moduleId: ShipModuleId) {
	const surface = entity.surface;
	const targetCenter = {
		x: math.floor(entity.position.x),
		y: math.floor(entity.position.y),
	};
	const targetRotation = normalizeRotation(entity.direction);
	entity.destroy();

	if (playerIndex === undefined) return;
	const player = game.players[playerIndex];
	if (!player) return;
	const session = storage.shipPlacementByPlayer[playerIndex];
	if (!session || session.moduleId !== moduleId) return;

	const result = placeOrMoveModule(moduleId, targetCenter, targetRotation, surface);
	if (!result.ok) {
		showFlyingText(player, targetCenter, result.message ?? ['warpage.module-placement-invalid']);
		givePlacementCarrier(player, moduleId);
		refreshPlacementSessionRenders(player, session);
		return;
	}

	clearPlacementSession(player.index);
	recomputeBridges(surface);
	refreshAllShipModuleRosters();
}

function placeOrMoveModule(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	surface: LuaSurface,
): PlacementResult {
	ensureInitialShipLayout();
	const module = storage.shipModules[moduleId];
	if (!module.placed) return placeNewModule(moduleId, center, rotation, surface);
	return moveModule(moduleId, center, rotation, surface);
}

function placeNewModule(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	surface: LuaSurface,
): PlacementResult {
	const validation = validateDestination(moduleId, center, rotation, surface, moduleId);
	if (!validation.ok) return validation;

	setTilesToShip(surface, moduleWorldTiles(moduleId, center, rotation));
	const module = storage.shipModules[moduleId];
	module.center = { x: center.x, y: center.y };
	module.rotation = rotation;
	module.placed = true;
	module.connectorUnitNumbers = [];
	ensureModuleDefaultConnectors(moduleId, surface);
	return { ok: true };
}

function moveModule(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	surface: LuaSurface,
): PlacementResult {
	const module = storage.shipModules[moduleId];
	if (module.center.x === center.x && module.center.y === center.y && module.rotation === rotation) return { ok: true };

	const sourceTiles = moduleWorldTiles(moduleId, module.center, module.rotation);
	const sourceTileKeys = moduleWorldTileKeys(moduleId, module.center, module.rotation);
	const destinationTiles = moduleWorldTiles(moduleId, center, rotation);
	const destinationTileKeys = moduleWorldTileKeys(moduleId, center, rotation);
	for (const key of Object.keys(sourceTileKeys))
		if (destinationTileKeys[key]) return { ok: false, message: ['warpage.module-move-overlap'] };

	const validation = validateDestination(moduleId, center, rotation, surface, moduleId);
	if (!validation.ok) return validation;

	const connectorSnapshot = snapshotModuleConnectors(moduleId);
	const removeSourceConnectorsResult = removeModuleConnectors(moduleId);
	if (!removeSourceConnectorsResult.ok) return removeSourceConnectorsResult;

	const destinationTileSnapshot = snapshotTileNames(surface, destinationTiles);
	const destinationConnectorsCreated: number[] = [];
	const rollback = () => {
		removeConnectorsByUnitNumber(destinationConnectorsCreated);
		destroyEntitiesInTileSet(surface, destinationTileKeys);
		restoreTileNames(surface, destinationTileSnapshot);
		restoreModuleConnectors(moduleId, connectorSnapshot, module.center, module.rotation, surface);
	};

	const deltaRotation = rotationDelta(module.rotation, rotation);
	const delta = {
		x: center.x - module.center.x,
		y: center.y - module.center.y,
	};

	if (deltaRotation !== defines.direction.north) {
		const sourceEntities = entitiesInsideTileSet(surface, sourceTileKeys);
		for (const entity of sourceEntities) {
			if (entity.type === 'character') continue;
			if (entity.name === names.connector) continue;
			rollback();
			return { ok: false, message: ['warpage.module-move-rotate-blocked'] };
		}

		setTilesToShip(surface, destinationTiles);
		const createRotatedConnectorsResult = recreateModuleConnectorsWithTransform(
			moduleId,
			connectorSnapshot,
			module.center,
			center,
			deltaRotation,
			surface,
			destinationConnectorsCreated,
		);
		if (!createRotatedConnectorsResult.ok) {
			rollback();
			return createRotatedConnectorsResult;
		}
	} else {
		try {
			surface.clone_brush({
				source_offset: { x: 0, y: 0 },
				destination_offset: delta,
				source_positions: sourceTiles.map(tile => ({ x: tile.x, y: tile.y })),
				clone_tiles: true,
				clone_entities: true,
				clone_decoratives: false,
				clear_destination_entities: false,
				clear_destination_decoratives: false,
				manual_collision_mode: true,
			});
		} catch (error) {
			restoreModuleConnectors(moduleId, connectorSnapshot, module.center, module.rotation, surface);
			log(`[ship] clone_brush move failed: ${error}`);
			return { ok: false, message: ['warpage.module-placement-invalid'] };
		}

		const recreateConnectorsResult = recreateModuleConnectorsWithTransform(
			moduleId,
			connectorSnapshot,
			module.center,
			center,
			defines.direction.north,
			surface,
			destinationConnectorsCreated,
		);
		if (!recreateConnectorsResult.ok) {
			rollback();
			return recreateConnectorsResult;
		}
	}

	destroyEntitiesInTileSet(surface, sourceTileKeys);
	clearModuleSourceTiles(sourceTiles, surface);
	module.center = { x: center.x, y: center.y };
	module.rotation = rotation;
	module.placed = true;
	recomputeBridges(surface);
	return { ok: true };
}

function clearModuleSourceTiles(sourceTiles: MapPosition[], surface: LuaSurface) {
	const clearTiles: TileWrite[] = [];
	for (const tile of sourceTiles)
		clearTiles.push({
			name: 'foundation',
			position: tile,
		});

	if (clearTiles.length > 0) surface.set_tiles(clearTiles, true, false);
}

function snapshotModuleConnectors(moduleId: ShipModuleId) {
	const module = storage.shipModules[moduleId];
	return module.connectorUnitNumbers
		.map(unitNumber => {
			const connector = storage.shipConnectors[`${unitNumber}`];
			if (!connector) return;
			return {
				orientation: connector.orientation,
				side: connector.side,
				topLeft: {
					x: connector.topLeft.x,
					y: connector.topLeft.y,
				},
			};
		})
		.filter(connector => connector !== undefined) as Array<{
		orientation: 'vertical' | 'horizontal';
		side: 'north' | 'east' | 'south' | 'west';
		topLeft: MapPosition;
	}>;
}

function removeModuleConnectors(moduleId: ShipModuleId) {
	const module = storage.shipModules[moduleId];
	for (const unitNumber of module.connectorUnitNumbers) {
		const connectorEntity = game.get_entity_by_unit_number(unitNumber as any);
		if (!connectorEntity || connectorEntity.name !== names.connector) continue;
		connectorEntity.destroy();
		delete storage.shipConnectors[`${unitNumber}`];
	}
	module.connectorUnitNumbers = [];
	return { ok: true as const };
}

function restoreModuleConnectors(
	moduleId: ShipModuleId,
	connectors: Array<{
		orientation: 'vertical' | 'horizontal';
		side: 'north' | 'east' | 'south' | 'west';
		topLeft: MapPosition;
	}>,
	center: MapPosition,
	rotation: ShipRotation,
	surface: LuaSurface,
) {
	const module = storage.shipModules[moduleId];
	module.center = { x: center.x, y: center.y };
	module.rotation = rotation;
	module.connectorUnitNumbers = [];
	for (const connector of connectors) {
		const created = createEntity(surface, {
			name: names.connector,
			position: connectorEntityPosition(connector.topLeft, connector.orientation),
			direction: connectorDirection(connector.orientation),
		});
		registerConnectorEntity(
			created,
			moduleId,
			{
				topLeft: connector.topLeft,
				orientation: connector.orientation,
				tiles: connectorToTiles(connector.topLeft, connector.orientation),
			},
			connector.side,
		);
	}
}

function recreateModuleConnectorsWithTransform(
	moduleId: ShipModuleId,
	connectors: Array<{
		orientation: 'vertical' | 'horizontal';
		side: 'north' | 'east' | 'south' | 'west';
		topLeft: MapPosition;
	}>,
	sourceCenter: MapPosition,
	destinationCenter: MapPosition,
	deltaRotation: ShipRotation,
	surface: LuaSurface,
	destinationConnectorsCreated: number[],
): PlacementResult {
	const module = storage.shipModules[moduleId];
	module.connectorUnitNumbers = [];

	for (const connector of connectors) {
		const relativeTopLeft = {
			x: connector.topLeft.x - sourceCenter.x,
			y: connector.topLeft.y - sourceCenter.y,
		};
		const relativeConnector = rotateConnectorTopLeftAroundCenter(relativeTopLeft, connector.orientation, deltaRotation);
		const worldTopLeft = {
			x: destinationCenter.x + relativeConnector.topLeft.x,
			y: destinationCenter.y + relativeConnector.topLeft.y,
		};
		const side = rotateSide(connector.side, deltaRotation);
		const created = createEntity(surface, {
			name: names.connector,
			position: connectorEntityPosition(worldTopLeft, relativeConnector.orientation),
			direction: connectorDirection(relativeConnector.orientation),
		});
		const unitNumber = created.unit_number;
		if (!unitNumber) return { ok: false, message: ['warpage.module-move-connector-failed'] };
		destinationConnectorsCreated.push(unitNumber);
		registerConnectorEntity(
			created,
			moduleId,
			{
				topLeft: worldTopLeft,
				orientation: relativeConnector.orientation,
				tiles: connectorToTiles(worldTopLeft, relativeConnector.orientation),
			},
			side,
		);
	}

	module.center = { x: destinationCenter.x, y: destinationCenter.y };
	return { ok: true };
}

function validateDestination(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	surface: LuaSurface,
	excludedModuleId?: ShipModuleId,
): PlacementResult {
	const destinationTileKeys = moduleWorldTileKeys(moduleId, center, rotation);

	for (const otherId of shipModuleIds) {
		if (otherId === excludedModuleId) continue;
		const other = storage.shipModules[otherId];
		if (!other.placed) continue;
		const otherTileKeys = moduleWorldTileKeys(otherId, other.center, other.rotation);
		for (const key of Object.keys(destinationTileKeys))
			if (otherTileKeys[key]) return { ok: false, message: ['warpage.module-placement-overlap'] };
	}

	const entities = entitiesInsideTileSet(surface, destinationTileKeys);
	for (const entity of entities) {
		if (entity.type === 'character') continue;
		return { ok: false, message: ['warpage.module-placement-blocked'] };
	}
	return { ok: true };
}

function entitiesInsideTileSet(surface: LuaSurface, tileKeys: Record<string, true | undefined>) {
	const allKeys = Object.keys(tileKeys);
	if (allKeys.length === 0) return [];

	let minX = 0;
	let maxX = 0;
	let minY = 0;
	let maxY = 0;
	for (const [index, key] of allKeys.entries()) {
		const [xString, yString] = key.split(',');
		const x = Number(xString);
		const y = Number(yString);
		if (index === 0) {
			minX = x;
			maxX = x;
			minY = y;
			maxY = y;
			continue;
		}
		if (x < minX) minX = x;
		if (x > maxX) maxX = x;
		if (y < minY) minY = y;
		if (y > maxY) maxY = y;
	}

	const entities = surface.find_entities_filtered({
		area: [
			[minX, minY],
			[maxX + 1, maxY + 1],
		],
	});
	return entities.filter(entity => entityOverlapsTileSet(entity, tileKeys));
}

function entityOverlapsTileSet(entity: LuaEntity, tileKeys: Record<string, true | undefined>) {
	const box = entity.bounding_box;
	const minX = math.floor(box.left_top.x);
	const minY = math.floor(box.left_top.y);
	const maxX = math.ceil(box.right_bottom.x) - 1;
	const maxY = math.ceil(box.right_bottom.y) - 1;
	if (maxX < minX || maxY < minY)
		return tileKeys[tileKey(math.floor(entity.position.x), math.floor(entity.position.y))] === true;
	for (let x = minX; x <= maxX; x += 1) for (let y = minY; y <= maxY; y += 1) if (tileKeys[tileKey(x, y)]) return true;

	return false;
}

function destroyEntitiesInTileSet(surface: LuaSurface, tileKeys: Record<string, true | undefined>) {
	for (const entity of entitiesInsideTileSet(surface, tileKeys)) {
		if (entity.type === 'character') continue;
		entity.destroy();
	}
}

function snapshotTileNames(surface: LuaSurface, tiles: MapPosition[]) {
	const snapshot: Record<string, string> = {};
	for (const tile of tiles) snapshot[tileKey(tile.x, tile.y)] = surface.get_tile(tile.x, tile.y).name;
	return snapshot;
}

function restoreTileNames(surface: LuaSurface, snapshot: Record<string, string>) {
	const writes: TileWrite[] = [];
	for (const [key, tileName] of Object.entries(snapshot)) {
		const [xString, yString] = key.split(',');
		writes.push({
			name: tileName,
			position: {
				x: Number(xString),
				y: Number(yString),
			},
		});
	}
	if (writes.length > 0) surface.set_tiles(writes, true, false);
}

function removeConnectorsByUnitNumber(unitNumbers: number[]) {
	for (const unitNumber of unitNumbers) {
		const connector = game.get_entity_by_unit_number(unitNumber as any);
		if (!connector || connector.name !== names.connector) continue;
		connector.destroy();
		delete storage.shipConnectors[`${unitNumber}`];
	}
}

function handleConnectorBuilt(entity: LuaEntity, playerIndex?: number) {
	ensureInitialShipLayout();
	const placement = readConnectorPlacement(entity);
	const owner = findConnectorOwner(placement);
	if (!owner) return rejectConnector(entity, playerIndex);
	if (findConnectorAtPlacement(placement)) return rejectConnector(entity, playerIndex);

	registerConnectorEntity(entity, owner.moduleId, placement, owner.side);
	recomputeBridges(entity.surface);
	for (const player of game.connected_players) {
		const session = storage.shipPlacementByPlayer[player.index];
		if (!session) continue;
		if (session.moduleId !== owner.moduleId) continue;
		refreshPlacementSessionRenders(player, session);
	}
}

function findConnectorOwner(placement: ShipConnectorPlacement) {
	let matched: { moduleId: ShipModuleId; side: ShipConnectorSide } | undefined;
	for (const moduleId of shipModuleIds) {
		const module = storage.shipModules[moduleId];
		if (!module.placed) continue;
		const side = connectorPlacementEdgeSide(moduleId, module.center, module.rotation, placement, placement.sideHint);
		if (!side) continue;
		if (connectorPlacementOverlapsModule(moduleId, placement)) continue;
		if (matched) return;
		matched = { moduleId, side };
	}
	return matched;
}

function connectorPlacementOverlapsModule(moduleId: ShipModuleId, placement: ShipConnectorPlacement) {
	const module = storage.shipModules[moduleId];
	const occupied: Record<string, true | undefined> = {};
	for (const unitNumber of module.connectorUnitNumbers) {
		const connector = storage.shipConnectors[`${unitNumber}`];
		if (!connector) continue;
		for (const tile of connectorToTiles(connector.topLeft, connector.orientation))
			occupied[tileKey(tile.x, tile.y)] = true;
	}
	for (const tile of placement.tiles) if (occupied[tileKey(tile.x, tile.y)]) return true;
	return false;
}

function findConnectorAtPlacement(placement: ShipConnectorPlacement) {
	for (const connector of Object.values(storage.shipConnectors)) {
		if (!connector) continue;
		if (connector.orientation !== placement.orientation) continue;
		if (connector.topLeft.x !== placement.topLeft.x) continue;
		if (connector.topLeft.y !== placement.topLeft.y) continue;
		return connector;
	}
}

function registerConnectorEntity(
	entity: LuaEntity,
	moduleId: ShipModuleId,
	placement: ShipConnectorPlacement,
	side: ShipConnectorSide,
) {
	const unitNumber = entity.unit_number;
	if (!unitNumber) throw new Error('Connector missing unit number.');

	const unitKey = `${unitNumber}`;
	storage.shipConnectors[unitKey] = {
		moduleId,
		orientation: placement.orientation,
		side,
		topLeft: {
			x: placement.topLeft.x,
			y: placement.topLeft.y,
		},
	};
	const module = storage.shipModules[moduleId];
	if (!module.connectorUnitNumbers.includes(unitNumber)) module.connectorUnitNumbers.push(unitNumber);
}

function rejectConnector(entity: LuaEntity, playerIndex?: number) {
	if (playerIndex !== undefined) {
		const player = game.players[playerIndex];
		if (player && player.surface.index === entity.surface.index)
			showFlyingText(player, entity.position, ['warpage.connector-edge-error']);
	} else
		for (const player of game.connected_players) {
			if (player.surface.index !== entity.surface.index) continue;
			showFlyingText(player, entity.position, ['warpage.connector-edge-error']);
		}

	entity.destroy();
	entity.surface.spill_item_stack({
		allow_belts: false,
		drop_full_stack: false,
		enable_looted: true,
		force: entity.force,
		position: entity.position,
		stack: {
			count: 1,
			name: names.connector,
		},
	});
}

function removeConnectorFromLayout(entity: LuaEntity) {
	const unitNumber = entity.unit_number;
	if (!unitNumber) return;

	const connector = storage.shipConnectors[`${unitNumber}`];
	if (!connector) return;
	const module = storage.shipModules[connector.moduleId];
	module.connectorUnitNumbers = module.connectorUnitNumbers.filter(value => value !== unitNumber);
	delete storage.shipConnectors[`${unitNumber}`];
	recomputeBridges(entity.surface);
}

function ensureModuleDefaultConnectors(moduleId: ShipModuleId, surface: LuaSurface) {
	const module = storage.shipModules[moduleId];
	for (const connector of moduleDefaultConnectorPlacements(moduleId, module.center, module.rotation)) {
		const existing = findConnectorAtPlacement(connector);
		if (existing) continue;
		const created = createEntity(surface, {
			name: names.connector,
			position: connectorEntityPosition(connector.topLeft, connector.orientation),
			direction: connectorDirection(connector.orientation),
		});
		registerConnectorEntity(created, moduleId, connector, connector.side);
	}
}

function recomputeBridges(surface: LuaSurface) {
	ensureInitialShipLayout();
	pruneInvalidConnectors();
	autoCreateEdgeConnectors(surface);

	const oldBridgeTiles: Record<string, true | undefined> = {};
	for (const bridge of Object.values(storage.shipBridges))
		for (const tile of bridge.tiles) oldBridgeTiles[tileKey(tile.x, tile.y)] = true;

	const newBridges: Record<
		string,
		{
			connectorUnitNumber: number;
			targetConnectorUnitNumber?: number;
			tiles: MapPosition[];
		}
	> = {};
	const newBridgeTiles: Record<string, true | undefined> = {};
	for (const [unitKey, connector] of Object.entries(storage.shipConnectors)) {
		if (!connector) continue;
		const sourceUnitNumber = Number(unitKey);
		const target = findBridgeTarget(connector);
		if (!target) continue;
		const tiles = bridgeTilesBetween(connector, target);
		newBridges[unitKey] = {
			connectorUnitNumber: sourceUnitNumber,
			targetConnectorUnitNumber: target.unitNumber,
			tiles,
		};
		for (const tile of tiles) newBridgeTiles[tileKey(tile.x, tile.y)] = true;
	}

	const moduleTiles: Record<string, true | undefined> = {};
	for (const moduleId of shipModuleIds) {
		const module = storage.shipModules[moduleId];
		if (!module.placed) continue;
		const keys = moduleWorldTileKeys(moduleId, module.center, module.rotation);
		for (const key of Object.keys(keys)) moduleTiles[key] = true;
	}

	const clearWrites: TileWrite[] = [];
	for (const key of Object.keys(oldBridgeTiles)) {
		if (newBridgeTiles[key]) continue;
		if (moduleTiles[key]) continue;
		const [xString, yString] = key.split(',');
		clearWrites.push({
			name: 'foundation',
			position: {
				x: Number(xString),
				y: Number(yString),
			},
		});
	}
	if (clearWrites.length > 0) surface.set_tiles(clearWrites, true, false);

	const setWrites: TileWrite[] = [];
	for (const key of Object.keys(newBridgeTiles)) {
		const [xString, yString] = key.split(',');
		setWrites.push({
			name: names.tile,
			position: {
				x: Number(xString),
				y: Number(yString),
			},
		});
	}
	if (setWrites.length > 0) surface.set_tiles(setWrites, true, false);

	storage.shipBridges = newBridges;
}

function pruneInvalidConnectors() {
	for (const [unitKey, connector] of Object.entries(storage.shipConnectors)) {
		const unitNumber = Number(unitKey);
		const entity = game.get_entity_by_unit_number(unitNumber as any);
		if (entity && entity.name === names.connector) continue;
		const module = storage.shipModules[connector.moduleId];
		module.connectorUnitNumbers = module.connectorUnitNumbers.filter(value => value !== unitNumber);
		delete storage.shipConnectors[unitKey];
	}
}

function autoCreateEdgeConnectors(surface: LuaSurface) {
	const newConnectors: Array<{
		moduleId: ShipModuleId;
		placement: ShipConnectorPlacement;
		side: ShipConnectorSide;
	}> = [];
	for (const connector of Object.values(storage.shipConnectors)) {
		if (!connector) continue;
		const sourcePlacement = {
			topLeft: connector.topLeft,
			orientation: connector.orientation,
			tiles: connectorToTiles(connector.topLeft, connector.orientation),
		};
		const outward = outwardVector(connector.side);
		const wantedSide = oppositeSide(connector.side);
		for (let distance = 1; distance <= bridgeMaxRange; distance += 1) {
			const candidate = translateConnectorPlacement(sourcePlacement, outward, distance);
			const existing = findConnectorAtPlacement(candidate);
			if (existing) break;

			const owner = findEdgeOwnerForConnector(candidate, wantedSide, connector.moduleId);
			if (!owner) continue;
			newConnectors.push({
				moduleId: owner.moduleId,
				placement: candidate,
				side: owner.side,
			});
			break;
		}
	}

	for (const connector of newConnectors) {
		if (findConnectorAtPlacement(connector.placement)) continue;
		const created = createEntity(surface, {
			name: names.connector,
			position: connectorEntityPosition(connector.placement.topLeft, connector.placement.orientation),
			direction: connectorDirection(connector.placement.orientation),
		});
		registerConnectorEntity(created, connector.moduleId, connector.placement, connector.side);
	}
}

function findEdgeOwnerForConnector(
	placement: ShipConnectorPlacement,
	side: ShipConnectorSide,
	excludedModuleId: ShipModuleId,
): { moduleId: ShipModuleId; side: ShipConnectorSide } | undefined {
	for (const moduleId of shipModuleIds) {
		if (moduleId === excludedModuleId) continue;
		const module = storage.shipModules[moduleId];
		if (!module.placed) continue;
		const edge = connectorPlacementEdgeSide(moduleId, module.center, module.rotation, placement, side);
		if (!edge || edge !== side) continue;
		if (connectorPlacementOverlapsModule(moduleId, placement)) continue;
		return {
			moduleId,
			side: edge,
		};
	}
}

function findBridgeTarget(source: {
	moduleId: ShipModuleId;
	orientation: 'vertical' | 'horizontal';
	side: 'north' | 'east' | 'south' | 'west';
	topLeft: MapPosition;
}) {
	const sourcePlacement = {
		topLeft: source.topLeft,
		orientation: source.orientation,
		tiles: connectorToTiles(source.topLeft, source.orientation),
	};
	const outward = outwardVector(source.side);
	const wantedSide = oppositeSide(source.side);
	for (let distance = 1; distance <= bridgeMaxRange; distance += 1) {
		const candidate = translateConnectorPlacement(sourcePlacement, outward, distance);
		const target = findConnectorAtPlacement(candidate);
		if (!target) continue;
		if (target.side !== wantedSide) continue;
		const targetUnitNumber = findConnectorUnitNumber(target);
		if (!targetUnitNumber) continue;
		return {
			unitNumber: targetUnitNumber,
			record: target,
		};
	}
}

function findConnectorUnitNumber(connector: {
	moduleId: ShipModuleId;
	orientation: 'vertical' | 'horizontal';
	side: 'north' | 'east' | 'south' | 'west';
	topLeft: MapPosition;
}) {
	for (const [unitKey, entry] of Object.entries(storage.shipConnectors)) {
		if (!entry) continue;
		if (entry.moduleId !== connector.moduleId) continue;
		if (entry.orientation !== connector.orientation) continue;
		if (entry.side !== connector.side) continue;
		if (entry.topLeft.x !== connector.topLeft.x || entry.topLeft.y !== connector.topLeft.y) continue;
		return Number(unitKey);
	}
}

function bridgeTilesBetween(
	source: {
		moduleId: ShipModuleId;
		orientation: 'vertical' | 'horizontal';
		side: 'north' | 'east' | 'south' | 'west';
		topLeft: MapPosition;
	},
	target: {
		unitNumber: number;
		record: {
			moduleId: ShipModuleId;
			orientation: 'vertical' | 'horizontal';
			side: 'north' | 'east' | 'south' | 'west';
			topLeft: MapPosition;
		};
	},
) {
	const sourcePlacement = {
		topLeft: source.topLeft,
		orientation: source.orientation,
		tiles: connectorToTiles(source.topLeft, source.orientation),
	};
	const outward = outwardVector(source.side);
	const distance =
		math.abs(target.record.topLeft.x - source.topLeft.x) + math.abs(target.record.topLeft.y - source.topLeft.y);
	const tiles: MapPosition[] = [];
	for (let step = 1; step < distance; step += 1) {
		const placement = translateConnectorPlacement(sourcePlacement, outward, step);
		for (const tile of placement.tiles) tiles.push(tile);
	}
	return tiles;
}

function setTilesToShip(surface: LuaSurface, tiles: MapPosition[]) {
	if (tiles.length === 0) return;
	const writes: TileWrite[] = tiles.map(tile => ({
		name: names.tile,
		position: tile,
	}));
	surface.set_tiles(writes, true, false);
}

function showFlyingText(player: LuaPlayer, position: MapPosition, text: LocalisedString) {
	player.create_local_flying_text({
		position,
		surface: player.surface,
		text,
	});
}

function purgePlacementCarrierItems(player: LuaPlayer) {
	const cursorStack = player.cursor_stack;
	if (cursorStack?.valid_for_read && placementCarrierItems[cursorStack.name]) cursorStack.clear();

	const inventories = [
		player.get_main_inventory(),
		player.get_inventory(defines.inventory.character_trash),
		player.get_inventory(defines.inventory.god_main),
		player.get_inventory(defines.inventory.editor_main),
	];
	for (const inventory of inventories) {
		if (!inventory) continue;
		for (const itemName of placementCarrierItemNames) {
			const count = inventory.get_item_count(itemName);
			if (count > 0) inventory.remove({ name: itemName, count });
		}
	}
}

function moduleIdFromPlacementEntityName(name: string) {
	for (const moduleId of shipModuleIds) if (name === names.modulePlacementEntity(moduleId)) return moduleId;
}

function moduleIdFromPlacementItemName(name: string) {
	for (const moduleId of shipModuleIds) if (name === names.modulePlacementItem(moduleId)) return moduleId;
}

registerGlobal('ensureInitialShipLayout', ensureInitialShipLayout);
registerGlobal('ensureInitialShipModule', ensureInitialShipModule);
registerGlobal('refreshShipModuleUnlocks', refreshShipModuleUnlocks);
registerGlobal('ensureModuleRoster', ensureModuleRoster);
registerGlobal('refreshAllShipModuleRosters', refreshAllShipModuleRosters);
