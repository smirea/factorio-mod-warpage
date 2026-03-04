import { gui, on_event, parseBlueprint } from '@/lib/utils';
import {
	connectorRange,
	getShipModule,
	names,
	placeableModules,
	shipConnectorSizes,
	ShipModuleId,
	shipModules,
} from './constants';
import { BlueprintEntityWrite, LuaPlayer, TileWrite } from 'factorio:runtime';
import { MapPositionStruct } from 'factorio:prototype';
import { BBox, bboxIntersect, rotateCoordinate } from '@/lib/geometry';

let placing:
	| { type: 'module'; player_index: number; id: (typeof placeableModules)[number] }
	| { type: 'connector'; player_index: number; size: number }
	| null = null;

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

	const clearBuild = () => {
		placing = null;
		player.clear_cursor();
		createGUI(player);
	};

	const placingBox = { id: placing.id, position: event.position, direction: event.direction };
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

	player.cursor_stack
		.build_blueprint({
			force: player.force,
			position: event.position,
			surface: player.surface,
			direction: event.direction,
		})
		.forEach(item => {
			if (item == null || !item.valid) return;
			item.revive();
		});

	if (storage.ship.modules[placing.id] != null) {
		// TODO: remove old module tiles and entitites from old location
	}

	storage.ship.modules[placing.id] = {
		connectors: [],
		position: event.position,
		direction: event.direction,
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
				if (storage.ship.modules[moduleId]) {
					// TODO: the module is moving, draw a border around the module and clear it once it's placed (save a global var to track this)
				}
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
				player.clear_cursor();
			} else {
				placing = { type: 'connector', size, player_index: event.player_index };
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
	for (const [x, y] of aMod.tiles) {
		const tile = rotateCoordinate({ x, y }, a.direction);
		const worldX = Math.round(a.position.x + tile.x);
		const worldY = Math.round(a.position.y + tile.y);
		aTileKeys[`${worldX},${worldY}`] = true;
	}

	for (const [x, y] of bMod.tiles) {
		const tile = rotateCoordinate({ x, y }, b.direction);
		const worldX = Math.round(b.position.x + tile.x);
		const worldY = Math.round(b.position.y + tile.y);
		if (aTileKeys[`${worldX},${worldY}`] === true) return true;
	}
	return false;
}
