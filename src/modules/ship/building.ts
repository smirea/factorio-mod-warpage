import { gui, on_event, parseBlueprint } from '@/lib/utils';
import { getShipModule, names, placeableModules, shipConnectorSizes, ShipModuleId, shipModules } from './constants';
import { LuaEntity, LuaPlayer, LuaRenderObject, TileWrite } from 'factorio:runtime';
import { MapPositionStruct } from 'factorio:prototype';
import { BBox, bboxIntersect, rotateCoordinate } from '@/lib/geometry';

let placing:
	| { type: 'module'; player_index: number; id: (typeof placeableModules)[number] }
	| { type: 'connector'; player_index: number; size: number }
	| null = null;
let movingModuleBorder: LuaRenderObject | null = null;

/**
 * Trade-offs on module build mode: Blueprint VS Item
 *
 * using a blueprint:
 * - pros: can visually show contents when copying, can be placed from map view
 * - cons: no live placement feedback, more finicky events (need to accurately track the player placing and cancel their build), more complex collision calculation (need to account for module collision), unlimited range
 *
 * using an item:
 * - pros: simpler logic, native module collision built in
 * - cons: cannot show contents when copying, can only be placed in range of player
 */

on_event('on_player_joined_game', event => createGUI(game.players[event.player_index]!));

on_event('on_player_cursor_stack_changed', event => {
	if (placing == null) return;
	const player = game.get_player(event.player_index);
	if (player == null) return;
	if (player.cursor_stack == null || player.cursor_stack.count === 0) {
		placing = null;
		clearMovingModuleBorder();
		createGUI(player);
	}
});

on_event('on_pre_build', event => {
	if (placing == null) return;
	if (placing.type !== 'module') return;
	if (event.player_index !== placing.player_index) return;
	const player = game.get_player(event.player_index);
	if (player == null) return;
	if (!player.cursor_stack) return;
	if (!player.cursor_stack.valid_for_read) return;
	if (!player.cursor_stack.is_blueprint) return;
	const previousModule = storage.ship.modules[placing.id];
	const placementDirection = event.direction;
	const placementPosition = getModuleTileAnchor(event.position);

	const clearBuild = () => {
		placing = null;
		clearMovingModuleBorder();
		player.clear_cursor();
		createGUI(player);
	};

	const placingBox = { id: placing.id, position: placementPosition, direction: placementDirection };
	for (const [moduleId, { position, direction }] of Object.entries(storage.ship.modules)) {
		if (moduleId === placing.id) continue; // ignores itself when moving a module
		const targetBox = { id: moduleId as any, position, direction };
		if (checkModuleIntersection(placingBox, targetBox)) {
			player.create_local_flying_text({
				position: event.position,
				surface: player.surface,
				text: 'cannot overlap existing modules',
			});
			clearBuild();
			// this is the only way i could find to simulate "canceling" the build action
			// const backup = player.cursor_stack.export_stack();
			// player.cursor_stack.import_stack(backup);
			return;
		}
	}

	if (previousModule != null) {
		const module = getShipModule(placing.id);
		const previousPosition = getModuleTileAnchor(previousModule.position);
		if (previousPosition.x === placementPosition.x && previousPosition.y === placementPosition.y) {
			clearBuild();
			return;
		}
		if (
			checkModuleIntersection(placingBox, {
				id: placing.id,
				position: previousPosition,
				direction: previousModule.direction,
			})
		) {
			player.create_local_flying_text({
				position: event.position,
				surface: player.surface,
				text: 'cannot overlap old module footprint while moving',
			});
			clearBuild();
			return;
		}

		const sourceOffset = previousPosition;
		const destinationOffset = placementPosition;
		const sourceTilePositions = getModuleWorldPoints(previousPosition, previousModule.direction, module.tiles);
		const sourceShapePositions = getRotatedModulePoints(previousModule.direction, module.shapePoints);
		const destinationTilePositions = getModuleWorldPoints(placementPosition, placementDirection, module.tiles);
		const rotationChanged = previousModule.direction !== placementDirection;
		const rotationSteps = getRotationSteps(previousModule.direction, placementDirection);

		let minX = sourceTilePositions[0]!.x;
		let maxX = sourceTilePositions[0]!.x;
		let minY = sourceTilePositions[0]!.y;
		let maxY = sourceTilePositions[0]!.y;
		const sourceTileKeys: Record<string, true> = {};
		const resetTiles: TileWrite[] = [];
		for (const point of sourceTilePositions) {
			sourceTileKeys[`${point.x},${point.y}`] = true;
			if (point.x < minX) minX = point.x;
			if (point.x > maxX) maxX = point.x;
			if (point.y < minY) minY = point.y;
			if (point.y > maxY) maxY = point.y;
			resetTiles.push({
				name: 'foundation',
				position: point,
			});
		}
		let destinationMinX = destinationTilePositions[0]!.x;
		let destinationMaxX = destinationTilePositions[0]!.x;
		let destinationMinY = destinationTilePositions[0]!.y;
		let destinationMaxY = destinationTilePositions[0]!.y;
		for (const point of destinationTilePositions) {
			if (point.x < destinationMinX) destinationMinX = point.x;
			if (point.x > destinationMaxX) destinationMaxX = point.x;
			if (point.y < destinationMinY) destinationMinY = point.y;
			if (point.y > destinationMaxY) destinationMaxY = point.y;
		}
		const sourceEntities: LuaEntity[] = [];
		const sourceCharacters: LuaEntity[] = [];
		for (const entity of player.surface.find_entities_filtered({
			area: [
				[minX - 0.5, minY - 0.5],
				[maxX + 0.5, maxY + 0.5],
			],
		})) {
			const x1 = Math.floor(entity.position.x);
			const x2 = Math.ceil(entity.position.x);
			const y1 = Math.floor(entity.position.y);
			const y2 = Math.ceil(entity.position.y);
			if (
				sourceTileKeys[`${x1},${y1}`] !== true &&
				sourceTileKeys[`${x1},${y2}`] !== true &&
				sourceTileKeys[`${x2},${y1}`] !== true &&
				sourceTileKeys[`${x2},${y2}`] !== true
			)
				continue;
			if (entity.type === 'character') {
				sourceCharacters.push(entity);
				continue;
			}
			sourceEntities.push(entity);
		}
		const sourceCharacterUnitNumbers: Record<number, true> = {};
		const sourceCharacterOffsets = sourceCharacters.map(character => {
			if (character.unit_number != null) sourceCharacterUnitNumbers[character.unit_number] = true;
			return {
				character,
				offset: {
					x: character.position.x - sourceOffset.x,
					y: character.position.y - sourceOffset.y,
				},
			};
		});

		player.surface.clone_brush({
			source_offset: sourceOffset,
			destination_offset: destinationOffset,
			source_positions: sourceShapePositions,
			clone_tiles: !rotationChanged,
			clone_entities: true,
			clone_decoratives: false,
			manual_collision_mode: true,
		});
		if (rotationChanged) {
			player.cursor_stack
				.build_blueprint({
					force: player.force,
					position: placementPosition,
					surface: player.surface,
					direction: placementDirection,
				})
				.forEach(item => {
					if (item == null || !item.valid) return;
					item.revive();
				});
		}
		for (const character of player.surface.find_entities_filtered({
			type: 'character',
			area: [
				[destinationMinX - 0.5, destinationMinY - 0.5],
				[destinationMaxX + 0.5, destinationMaxY + 0.5],
			],
		})) {
			if (character.player != null) continue;
			const unitNumber = character.unit_number;
			if (unitNumber != null && sourceCharacterUnitNumbers[unitNumber] === true) continue;
			character.destroy();
		}
		for (const { character, offset } of sourceCharacterOffsets) {
			if (!character.valid) continue;
			const rotatedOffset = rotatePointBySteps(offset, rotationSteps);
			character.teleport(
				{
					x: destinationOffset.x + rotatedOffset.x,
					y: destinationOffset.y + rotatedOffset.y,
				},
				player.surface,
				false,
				false,
				defines.build_check_type.manual,
			);
		}
		for (const entity of sourceEntities) {
			if (!entity.valid) continue;
			entity.destroy();
		}
		player.surface.set_tiles(resetTiles);
	} else {
		player.cursor_stack
			.build_blueprint({
				force: player.force,
				position: placementPosition,
				surface: player.surface,
				direction: placementDirection,
			})
			.forEach(item => {
				if (item == null || !item.valid) return;
				item.revive();
			});
	}

	storage.ship.modules[placing.id] = {
		connectors: previousModule?.connectors ?? [],
		position: placementPosition,
		direction: placementDirection,
	};
	clearBuild();
});

export function createGUI(player: LuaPlayer) {
	const parent = player.gui.left;
	const guiName = names.ns('moduleGui');
	gui.destroy(parent[guiName]);
	const frame = parent.add({
		type: 'frame',
		name: guiName,
		direction: 'vertical',
		caption: LOCALE('other', 'module-gui-title'),
	});
	const flow = frame.add({ type: 'flow', direction: 'vertical' });
	const columnContainer = flow.add({ type: 'flow', direction: 'horizontal' });
	const columns = [
		columnContainer.add({ type: 'flow', direction: 'vertical' }),
		columnContainer.add({ type: 'flow', direction: 'vertical' }),
		columnContainer.add({ type: 'flow', direction: 'vertical' }),
		columnContainer.add({ type: 'flow', direction: 'vertical' }),
	];
	let column = 0;
	for (const moduleId of placeableModules) {
		const button = columns[column]!.add({
			type: 'sprite-button',
			name: names.ns(`module-roster-button-${moduleId}`),
			sprite: names.ns(`module-icon-${moduleId}`),
			style: 'slot_sized_button',
			tooltip: moduleId,
			toggled: placing?.type === 'module' && placing.id === moduleId,
		});
		column = (column + 1) % table_size(columns);
		gui.addHandlers(button.name, ['on_gui_click'], event => {
			const player = game.get_player(event.player_index)!;
			if (placing?.type === 'module' && placing.id === moduleId) {
				placing = null;
				clearMovingModuleBorder();
				player.clear_cursor();
			} else {
				placing = { type: 'module', id: moduleId, player_index: event.player_index };
				const mod = shipModules[moduleId];
				const bp = parseBlueprint(mod.blueprint);
				const cursor = player.cursor_stack;
				if (cursor) {
					player.clear_cursor();
					cursor.set_stack({ name: 'blueprint', count: 1 });
					if (bp.entities != null) cursor.set_blueprint_entities(bp.entities);
					if (bp.tiles != null) cursor.set_blueprint_tiles(bp.tiles);
					player.cursor_stack_temporary = true;
				}
				drawMovingModuleBorder(player, moduleId);
			}
			createGUI(player);
		});
	}

	for (const size of shipConnectorSizes) {
		const row = flow.add({
			type: 'flow',
			name: names.ns(`connector-row-${size}`),
			direction: 'horizontal',
		});
		const button = row.add({
			type: 'sprite-button',
			name: names.ns(`connector-roster-button-${size}`),
			sprite: 'item/hazard-concrete',
			style: 'slot_sized_button',
			toggled: placing?.type === 'connector' && placing.size === size,
		});
		row.add({
			type: 'label',
			name: names.ns(`connector-label-${size}`),
			caption: LOCALE('other', 'connector-button-label', size),
		});
		gui.addHandlers(button.name, ['on_gui_click'], event => {
			const player = game.get_player(event.player_index)!;
			if (placing?.type === 'connector' && placing.size === size) {
				placing = null;
				clearMovingModuleBorder();
				player.clear_cursor();
			} else {
				placing = { type: 'connector', size, player_index: event.player_index };
				clearMovingModuleBorder();
				const cursor = player.cursor_stack;
				if (cursor) {
					player.clear_cursor();
					cursor.set_stack({ name: names.connectorPlacementItem(size), count: 1 });
					player.cursor_stack_temporary = true;
				}
			}
			createGUI(player);
		});
	}
}

function clearMovingModuleBorder() {
	if (movingModuleBorder == null) return;
	movingModuleBorder.destroy();
	movingModuleBorder = null;
}

function drawMovingModuleBorder(player: LuaPlayer, moduleId: ShipModuleId) {
	clearMovingModuleBorder();
	const module = storage.ship.modules[moduleId];
	if (module == null) return;
	const bounds = getModuleTileBounds(moduleId, module.position, module.direction);
	movingModuleBorder = rendering.draw_rectangle({
		surface: player.surface,
		left_top: bounds.topLeft,
		color: {
			r: 0.96,
			g: 0.39,
			b: 0.2,
			a: 0.95,
		},
		width: 3,
		players: [player.index],
		draw_on_ground: true,
		right_bottom: bounds.bottomRight,
	});
}

function getModuleBoudingBox(id: ShipModuleId, position: MapPositionStruct, direction: defines.direction): BBox {
	const mod = getShipModule(id);
	const isHorizontal = direction === defines.direction.east || direction === defines.direction.west;
	const width = isHorizontal ? mod.height : mod.width;
	const height = isHorizontal ? mod.width : mod.height;
	return {
		topLeft: {
			x: position.x - width / 2,
			y: position.y - height / 2,
		},
		bottomRight: {
			x: position.x + width / 2,
			y: position.y + height / 2,
		},
	};
}

function getModuleWorldPoints(
	position: MapPositionStruct,
	direction: defines.direction,
	points: ReadonlyArray<readonly [number, number]>,
) {
	const anchor = getModuleTileAnchor(position);
	const rotatedPoints = getRotatedModulePoints(direction, points);
	const worldPoints: Array<{ x: number; y: number }> = [];
	for (const rotated of rotatedPoints) {
		worldPoints.push({
			x: anchor.x + rotated.x,
			y: anchor.y + rotated.y,
		});
	}
	return worldPoints;
}

function getRotatedModulePoints(direction: defines.direction, points: ReadonlyArray<readonly [number, number]>) {
	const rotatedPoints: Array<{ x: number; y: number }> = [];
	for (const [x, y] of points) rotatedPoints.push(rotateCoordinate({ x, y }, direction));
	return rotatedPoints;
}

function getModuleTileAnchor(position: MapPositionStruct) {
	return {
		x: Math.round(position.x),
		y: Math.round(position.y),
	};
}

function getRotationSteps(from: defines.direction, to: defines.direction) {
	const rawDelta = Math.round((to - from) / 2);
	return ((rawDelta % 4) + 4) % 4;
}

function rotatePointBySteps(point: { x: number; y: number }, steps: number) {
	const normalizedSteps = ((steps % 4) + 4) % 4;
	if (normalizedSteps === 1) return { x: -point.y, y: point.x };
	if (normalizedSteps === 2) return { x: -point.x, y: -point.y };
	if (normalizedSteps === 3) return { x: point.y, y: -point.x };
	return { x: point.x, y: point.y };
}

function getModuleTileBounds(id: ShipModuleId, position: MapPositionStruct, direction: defines.direction): BBox {
	const module = getShipModule(id);
	const points = getModuleWorldPoints(position, direction, module.tiles);
	let minX = points[0]!.x;
	let maxX = points[0]!.x;
	let minY = points[0]!.y;
	let maxY = points[0]!.y;
	for (const point of points) {
		if (point.x < minX) minX = point.x;
		if (point.x > maxX) maxX = point.x;
		if (point.y < minY) minY = point.y;
		if (point.y > maxY) maxY = point.y;
	}
	return {
		topLeft: { x: minX, y: minY },
		bottomRight: { x: maxX + 1, y: maxY + 1 },
	};
}

function checkModuleIntersection(
	a: { id: ShipModuleId; position: MapPositionStruct; direction: defines.direction },
	b: { id: ShipModuleId; position: MapPositionStruct; direction: defines.direction },
) {
	const aBB = getModuleBoudingBox(a.id, a.position, a.direction);
	const bBB = getModuleBoudingBox(b.id, b.position, b.direction);
	if (!bboxIntersect(aBB, bBB)) return false;

	const aMod = getShipModule(a.id);
	const bMod = getShipModule(b.id);

	const aTileKeys: Record<string, true> = {};
	const aTiles = getModuleWorldPoints(a.position, a.direction, aMod.tiles);
	for (const tile of aTiles) aTileKeys[`${tile.x},${tile.y}`] = true;

	const bTiles = getModuleWorldPoints(b.position, b.direction, bMod.tiles);
	for (const tile of bTiles) if (aTileKeys[`${tile.x},${tile.y}`] === true) return true;
	return false;
}
