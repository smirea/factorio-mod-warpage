import '@/modules/ship/control.ts';
import '@/modules/thermite/control.ts';
import type { LuaPlayer } from 'factorio:runtime';
import { names as shipNames } from '@/modules/ship/constants';
import { createDestroyedHub, createHub } from '@/modules/ship/hub';
import { getCurrentSurface, on_event, registerGlobal } from '@/lib/utils';

const freeplayInterfaceName = 'freeplay';
const shipEntrancePosition = { x: 0, y: 5 };

const forbiddenStartItems = [
	'pistol',
	'submachine-gun',
	'firearm-magazine',
	'piercing-rounds-magazine',
	'uranium-rounds-magazine',
	'burner-mining-drill',
	'electric-mining-drill',
	'stone-furnace',
	'iron-plate',
	'wood',
	'small-electric-pole',
] as const;

const startingItems = [
	{ name: 'steel-furnace', count: 2, quality: 'legendary' as const },
	{ name: 'jellynut', count: 50 },
] as const;

const playerInventoryIds = [
	defines.inventory.character_main,
	defines.inventory.character_guns,
	defines.inventory.character_ammo,
	defines.inventory.character_trash,
] as const;

script.on_init(() => {
	initStorage();
	initStart();
});

script.on_configuration_changed(() => {
	initStorage();
	initStart();
});

on_event('on_player_created', event => {
	const player = game.get_player(event.player_index);
	if (!player?.valid) return;
	applyStartupToPlayer(player);
});

registerGlobal('initStorage', initStorage);
registerGlobal('initStart', initStart);

function initStorage() {
	storage.surface ||= shipNames.surface;
	storage.hubRepaired ??= false;
	storage.startConfiguredPlayerIndices ||= {};
}

function initStart() {
	const freeplay = remote.interfaces[freeplayInterfaceName];
	if (freeplay) {
		const createdItems = remote.call(freeplayInterfaceName, 'get_created_items') as Record<string, number | undefined>;
		const respawnItems = remote.call(freeplayInterfaceName, 'get_respawn_items') as Record<string, number | undefined>;

		for (const itemName of forbiddenStartItems) {
			createdItems[itemName] = undefined;
			respawnItems[itemName] = undefined;
		}

		remote.call(freeplayInterfaceName, 'set_created_items', createdItems);
		remote.call(freeplayInterfaceName, 'set_respawn_items', respawnItems);
		remote.call(freeplayInterfaceName, 'set_ship_items', {});
		remote.call(freeplayInterfaceName, 'set_debris_items', {});
		remote.call(freeplayInterfaceName, 'set_skip_intro', true);
		remote.call(freeplayInterfaceName, 'set_disable_crashsite', true);
	}

	const surface = getCurrentSurface();
	const hub = surface.find_entity(shipNames.hubLandingPad, [0, 0]);
	const destroyedHub = surface.find_entity(shipNames.destroyedHub, [0, 0]);

	if (hub?.valid) {
		storage.hubRepaired = true;
		destroyedHub?.destroy();
	} else if (storage.hubRepaired) {
		destroyedHub?.destroy();
		createHub();
	} else if (!destroyedHub?.valid) {
		createDestroyedHub(surface);
	}

	game.forces[shipNames.force]?.set_spawn_position(shipEntrancePosition, surface);
	for (const [, player] of pairs(game.players)) {
		if (!player?.valid) continue;
		applyStartupToPlayer(player);
	}
}

function applyStartupToPlayer(player: LuaPlayer) {
	if (storage.startConfiguredPlayerIndices[player.index]) return;
	for (const inventoryId of playerInventoryIds) {
		const inventory = player.get_inventory(inventoryId);
		if (!inventory) continue;

		for (const itemName of forbiddenStartItems) {
			const count = inventory.get_item_count(itemName);
			if (count > 0) inventory.remove({ name: itemName, count });
		}
	}

	for (const stack of startingItems) {
		player.insert(stack);
	}

	const surface = getCurrentSurface();
	const destination =
		surface.find_non_colliding_position('character', shipEntrancePosition, 16, 0.25, true) ?? shipEntrancePosition;
	player.teleport(destination, surface);
	storage.startConfiguredPlayerIndices[player.index] = true;
}
