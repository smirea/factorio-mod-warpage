import '@/modules/ship/control.ts';
import '@/modules/thermite/control.ts';
import type { LuaPlayer, LuaSurface, MapPosition } from 'factorio:runtime';
import { names as shipNames } from '@/modules/ship/constants';
import { ensureInitialShipModule } from '@/modules/ship/building';
import { createDestroyedHub, createHub } from '@/modules/ship/hub';
import { createEntity, getCurrentSurface, on_event, on_init, registerGlobal } from '@/lib/utils';

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
	{ count: 2, name: 'steel-furnace', quality: 'legendary' as const },
	{ count: 50, name: 'jellynut' },
] as const;

const playerInventoryIds = [
	defines.inventory.character_main,
	defines.inventory.character_guns,
	defines.inventory.character_ammo,
	defines.inventory.character_trash,
] as const;

on_init(() => {
	initStorage();
	initStart();
});

script.on_configuration_changed(() => {
	initStorage();
	initStart();
});

on_event('on_player_created', event => {
	const player = game.get_player(event.player_index);
	if (!player?.valid) {
		return;
	}
	const surface = getCurrentSurface();
	applyStartupToPlayer(player, surface, resolveStartupAnchor(surface));
});

registerGlobal('initStorage', initStorage);
registerGlobal('initStart', initStart);

function initStorage() {
	storage.surface ||= 'nauvis';
	storage.hubRepaired ??= false;
	storage.startupSuppliesSeeded ??= false;
	storage.startConfiguredPlayerIndices ||= {};
}

function initStart() {
	const { freeplay } = remote.interfaces;
	if (freeplay) {
		const createdItems = remote.call('freeplay', 'get_created_items') as Record<string, number | undefined>;
		const respawnItems = remote.call('freeplay', 'get_respawn_items') as Record<string, number | undefined>;

		for (const itemName of forbiddenStartItems) {
			createdItems[itemName] = undefined;
			respawnItems[itemName] = undefined;
		}

		remote.call('freeplay', 'set_created_items', createdItems);
		remote.call('freeplay', 'set_respawn_items', respawnItems);
		remote.call('freeplay', 'set_ship_items', {});
		remote.call('freeplay', 'set_debris_items', {});
		remote.call('freeplay', 'set_skip_intro', true);
		remote.call('freeplay', 'set_disable_crashsite', true);
	}

	const surface = getCurrentSurface();
	const hub = surface.find_entity(shipNames.hubLandingPad, [0, 0]);
	const destroyedHub = surface.find_entity(shipNames.destroyedHub, [0, 0]);

	if (hub?.valid) {
		storage.hubRepaired = true;
		ensureInitialShipModule(surface);
		destroyedHub?.destroy();
	} else if (storage.hubRepaired) {
		ensureInitialShipModule(surface);
		destroyedHub?.destroy();
		createHub();
	} else if (!destroyedHub?.valid) {
		createDestroyedHub(surface);
	}

	const activeDestroyedHub = surface.find_entity(shipNames.destroyedHub, [0, 0]);
	if (activeDestroyedHub?.valid) {
		const startupChestPosition = {
			x: activeDestroyedHub.position.x,
			y: activeDestroyedHub.position.y + activeDestroyedHub.tile_height / 2 + 1,
		};

		let startupChest = surface.find_entity('wooden-chest', startupChestPosition);
		if (!startupChest?.valid) {
			startupChest =
				createEntity(surface, {
					name: 'wooden-chest',
					position: startupChestPosition,
				}) ?? undefined;
		}

		if (startupChest?.valid && !storage.startupSuppliesSeeded) {
			const inventory = startupChest.get_inventory(defines.inventory.chest);
			if (inventory) {
				for (const stack of startingItems) {
					inventory.insert({ ...stack });
				}
			}
			storage.startupSuppliesSeeded = true;
		}
	}

	const startupAnchor = resolveStartupAnchor(surface);
	game.forces.player!.set_spawn_position(startupAnchor, surface);
	for (const [, player] of pairs(game.players)) {
		if (!player?.valid) {
			continue;
		}
		applyStartupToPlayer(player, surface, startupAnchor);
	}
}

function resolveStartupAnchor(surface: LuaSurface): MapPosition {
	const destroyedHub = surface.find_entity(shipNames.destroyedHub, [0, 0]);
	const startupChestPosition = destroyedHub?.valid
		? { x: destroyedHub.position.x, y: destroyedHub.position.y + destroyedHub.tile_height / 2 + 1 }
		: { x: 0, y: 5 };
	const startupChest = surface.find_entity('wooden-chest', startupChestPosition);

	if (startupChest?.valid) {
		return { x: startupChest.position.x + 2, y: startupChest.position.y };
	}

	return { x: startupChestPosition.x + 2, y: startupChestPosition.y };
}

function applyStartupToPlayer(player: LuaPlayer, surface: LuaSurface, startupAnchor: MapPosition) {
	if (storage.startConfiguredPlayerIndices[player.index]) {
		return;
	}
	for (const inventoryId of playerInventoryIds) {
		const inventory = player.get_inventory(inventoryId);
		if (!inventory) {
			continue;
		}

		for (const itemName of forbiddenStartItems) {
			const count = inventory.get_item_count(itemName);
			if (count > 0) {
				inventory.remove({ count, name: itemName });
			}
		}
	}

	const destination = surface.find_non_colliding_position('character', startupAnchor, 16, 0.25, true) ?? startupAnchor;
	player.teleport(destination, surface);
	storage.startConfiguredPlayerIndices[player.index] = true;
}
