import './hub';
// import type {
// 	LuaEntity,
// 	LuaForce,
// 	LuaGuiElement,
// 	LuaInventory,
// 	LuaPlayer,
// 	LuaSurface,
// 	OnGuiClosedEvent,
// 	OnGuiOpenedEvent,
// 	PlayerIndex,
// } from 'factorio:runtime';
// import { on_event, on_nth_tick } from '@/lib/utils';
// import { names } from './constants';
// import {
// 	cleanupHubParts,
// 	clearHubPlacementArea,
// 	findDestroyedHubContainer,
// 	findDestroyedHubRubble,
// 	findExistingHub,
// 	findHubPart,
// 	hubPipeLeftOffset,
// 	hubPipeRightOffset,
// 	isHubMain,
// 	placeHub,
// 	syncHubParts,
// } from './hub';

// const HUB_UI_UPDATE_INTERVAL = 30;
// const HUB_REPAIR_TEXT_LIFETIME = 2_147_483_647;
// const HUB_DESTROYED_CONTAINER_SLOT_COUNT = 48;

// type HubRepairRequirement = {
// 	item_name: string;
// 	amount: number;
// };

// type HubStoredStack = {
// 	name: string;
// 	count: number;
// 	quality: string;
// };

// type HubRepairStatus = {
// 	item_name: string;
// 	required: number;
// 	current: number;
// 	remaining: number;
// };

// type HubLifecycleEntities = {
// 	surface: LuaSurface;
// 	force: LuaForce;
// 	hub?: LuaEntity;
// 	destroyedHubContainer?: LuaEntity;
// 	destroyedHubRubble?: LuaEntity;
// };

// const HUB_REPAIR_REQUIREMENTS: HubRepairRequirement[] = [
// 	{ item_name: 'stone', amount: 200 },
// 	{ item_name: 'coal', amount: 200 },
// 	{ item_name: 'copper-ore', amount: 100 },
// 	{ item_name: 'iron-plate', amount: 100 },
// 	{ item_name: 'calcite', amount: 10 },
// ];

// let openHubsByPlayer: Record<number, LuaEntity | undefined> = {};
// let hubRepairStatusTextEntity: LuaEntity | undefined;
// let hubRepairStatusTextValue: string | undefined;

// const clamp01 = (value: number) => math.max(0, math.min(1, value));

// const requireSurface = (name: string): LuaSurface => {
// 	const surface = game.surfaces[name];
// 	if (!surface) throw new Error(`Missing surface '${name}'.`);
// 	return surface;
// };

// const requireForce = (name: string): LuaForce => {
// 	const force = game.forces[name];
// 	if (!force) throw new Error(`Missing force '${name}'.`);
// 	return force;
// };

// const requireInventory = (inventory: LuaInventory | undefined, message: string): LuaInventory => {
// 	if (!inventory) throw new Error(message);
// 	return inventory;
// };

// const destroyHubRepairStatusText = () => {
// 	if (hubRepairStatusTextEntity?.valid) {
// 		hubRepairStatusTextEntity.destroy();
// 	}
// 	hubRepairStatusTextEntity = undefined;
// 	hubRepairStatusTextValue = undefined;
// };

// const lockDestroyedHubContainer = (entity: LuaEntity) => {
// 	entity.destructible = false;
// 	entity.minable = false;
// };

// const configureDestroyedHubRubble = (entity: LuaEntity) => {
// 	entity.corpse_expires = false;
// 	entity.corpse_immune_to_entity_placement = true;
// };

// const computeRepairRequirementSlots = (requirement: HubRepairRequirement) => {
// 	const stackSize = prototypes.item[requirement.item_name]?.stack_size;
// 	if (!stackSize || stackSize < 1) {
// 		throw new Error(`Missing stack size for repair requirement item '${requirement.item_name}'.`);
// 	}
// 	return math.ceil(requirement.amount / stackSize);
// };

// const computeRequiredRepairSlots = () => {
// 	let totalSlots = 0;
// 	for (const requirement of HUB_REPAIR_REQUIREMENTS) {
// 		totalSlots += computeRepairRequirementSlots(requirement);
// 	}
// 	return totalSlots;
// };

// const configureDestroyedHubContainer = (destroyedHubContainer: LuaEntity) => {
// 	const inventory = requireInventory(
// 		destroyedHubContainer.get_inventory(defines.inventory.chest),
// 		'Missing destroyed hub container inventory.',
// 	);
// 	const requiredSlots = computeRequiredRepairSlots();
// 	if (requiredSlots > HUB_DESTROYED_CONTAINER_SLOT_COUNT) {
// 		throw new Error(
// 			`Hub repair slot requirements exceed destroyed hub inventory size: required=${requiredSlots}, size=${HUB_DESTROYED_CONTAINER_SLOT_COUNT}.`,
// 		);
// 	}

// 	for (let slotIndex = 1; slotIndex <= HUB_DESTROYED_CONTAINER_SLOT_COUNT; slotIndex += 1) {
// 		if (!inventory.set_filter(slotIndex, undefined)) {
// 			throw new Error(`Failed to clear destroyed hub inventory filter slot ${slotIndex}.`);
// 		}
// 	}
// 	inventory.set_bar(HUB_DESTROYED_CONTAINER_SLOT_COUNT);

// 	let slotIndex = 1;
// 	for (const requirement of HUB_REPAIR_REQUIREMENTS) {
// 		const requirementSlots = computeRepairRequirementSlots(requirement);
// 		for (let index = 1; index <= requirementSlots; index += 1) {
// 			if (!inventory.set_filter(slotIndex, requirement.item_name)) {
// 				throw new Error(
// 					`Failed to set destroyed hub inventory filter slot ${slotIndex} to item '${requirement.item_name}'.`,
// 				);
// 			}
// 			slotIndex += 1;
// 		}
// 	}
// };

// const createDestroyedHub = (surface: LuaSurface, force: LuaForce) => {
// 	clearHubPlacementArea(surface, names.hubPosition);

// 	const destroyedHubContainer = surface.create_entity({
// 		name: names.destroyedHubContainer,
// 		position: names.hubPosition,
// 		force,
// 		create_build_effect_smoke: false,
// 	} as never);
// 	if (!destroyedHubContainer) {
// 		throw new Error('Unable to create destroyed hub container at the hub origin.');
// 	}

// 	const destroyedHubRubble = surface.create_entity({
// 		name: names.destroyedHubRubble,
// 		position: names.hubPosition,
// 	} as never);
// 	if (!destroyedHubRubble) {
// 		throw new Error('Unable to create destroyed hub rubble at the hub origin.');
// 	}

// 	lockDestroyedHubContainer(destroyedHubContainer);
// 	configureDestroyedHubRubble(destroyedHubRubble);
// 	configureDestroyedHubContainer(destroyedHubContainer);
// 	return [destroyedHubContainer, destroyedHubRubble] as const;
// };

// const countItemAcrossQualities = (inventory: LuaInventory, itemName: string) => {
// 	let total = 0;
// 	for (const [, count] of pairs(inventory.get_item_quality_counts(itemName))) {
// 		total += count;
// 	}
// 	return total;
// };

// const removeItemAcrossQualities = (inventory: LuaInventory, itemName: string, targetCount: number) => {
// 	let removedTotal = 0;
// 	for (const [qualityName, qualityCount] of pairs(inventory.get_item_quality_counts(itemName))) {
// 		if (removedTotal >= targetCount) break;
// 		if (qualityCount <= 0) continue;
// 		const removeTarget = math.min(targetCount - removedTotal, qualityCount);
// 		removedTotal += inventory.remove({
// 			name: itemName,
// 			count: removeTarget,
// 			quality: qualityName,
// 		});
// 	}
// 	return removedTotal;
// };

// const snapshotInventoryStacks = (inventory: LuaInventory) => {
// 	const stacks: HubStoredStack[] = [];
// 	for (const stack of inventory) {
// 		if (!stack.valid_for_read) continue;
// 		const qualityName = stack.quality?.name;
// 		if (!qualityName) {
// 			throw new Error(`Missing quality name for stack '${stack.name}'.`);
// 		}
// 		stacks.push({
// 			name: stack.name,
// 			count: stack.count,
// 			quality: qualityName,
// 		});
// 	}
// 	return stacks;
// };

// const transferStacksToHubStorage = (hubEntity: LuaEntity, stacks: HubStoredStack[]) => {
// 	if (stacks.length === 0) return;

// 	const mainInventory = requireInventory(
// 		hubEntity.get_inventory(defines.inventory.cargo_landing_pad_main),
// 		'Missing hub main inventory.',
// 	);
// 	const trashInventory = requireInventory(
// 		hubEntity.get_inventory(defines.inventory.cargo_landing_pad_trash),
// 		'Missing hub trash inventory.',
// 	);

// 	for (const stack of stacks) {
// 		const insertedMain = mainInventory.insert({
// 			name: stack.name,
// 			count: stack.count,
// 			quality: stack.quality,
// 		});
// 		const remaining = stack.count - insertedMain;
// 		if (remaining <= 0) continue;

// 		const insertedTrash = trashInventory.insert({
// 			name: stack.name,
// 			count: remaining,
// 			quality: stack.quality,
// 		});
// 		if (insertedTrash !== remaining) {
// 			throw new Error(
// 				`Failed to transfer destroyed hub stack '${stack.name}' (quality ${stack.quality}): expected ${stack.count}, inserted ${
// 					insertedMain + insertedTrash
// 				}.`,
// 			);
// 		}
// 	}
// };

// const collectHubRepairStatus = (destroyedHubContainer: LuaEntity) => {
// 	const inventory = requireInventory(
// 		destroyedHubContainer.get_inventory(defines.inventory.chest),
// 		'Missing destroyed hub container inventory.',
// 	);

// 	let repairComplete = true;
// 	const status: HubRepairStatus[] = [];

// 	for (const requirement of HUB_REPAIR_REQUIREMENTS) {
// 		const current = countItemAcrossQualities(inventory, requirement.item_name);
// 		const remaining = math.max(requirement.amount - current, 0);
// 		if (remaining > 0) {
// 			repairComplete = false;
// 		}

// 		status.push({
// 			item_name: requirement.item_name,
// 			required: requirement.amount,
// 			current,
// 			remaining,
// 		});
// 	}

// 	return [repairComplete, status] as const;
// };

// const drawDestroyedHubRepairStatus = (destroyedHubContainer: LuaEntity, repairStatus: HubRepairStatus[]) => {
// 	const lines: string[] = [];
// 	for (const entry of repairStatus) {
// 		if (entry.remaining > 0) {
// 			lines.push(`[item=${entry.item_name}] ${entry.remaining}`);
// 		}
// 	}

// 	if (lines.length === 0) {
// 		destroyHubRepairStatusText();
// 		return;
// 	}

// 	const text = lines.join(' ');
// 	if (hubRepairStatusTextEntity?.valid && hubRepairStatusTextValue === text) {
// 		return;
// 	}

// 	destroyHubRepairStatusText();
// 	hubRepairStatusTextEntity =
// 		destroyedHubContainer.surface.create_entity({
// 			name: 'compi-speech-bubble',
// 			position: {
// 				x: destroyedHubContainer.position.x,
// 				y: destroyedHubContainer.position.y - 4.5,
// 			},
// 			target: destroyedHubContainer,
// 			text,
// 			lifetime: HUB_REPAIR_TEXT_LIFETIME,
// 		} as never) ?? undefined;
// 	hubRepairStatusTextValue = text;
// };

// const destroyEntityOrFail = (entity: LuaEntity, description: string) => {
// 	if (!entity.valid) return;
// 	const destroyed = entity.destroy();
// 	if (destroyed !== true && entity.valid) {
// 		throw new Error(`Unable to destroy ${description} at the hub origin.`);
// 	}
// };

// const consumeHubRepairItems = (destroyedHubContainer: LuaEntity) => {
// 	const inventory = requireInventory(
// 		destroyedHubContainer.get_inventory(defines.inventory.chest),
// 		'Missing destroyed hub container inventory.',
// 	);

// 	for (const requirement of HUB_REPAIR_REQUIREMENTS) {
// 		const removed = removeItemAcrossQualities(inventory, requirement.item_name, requirement.amount);
// 		if (removed !== requirement.amount) {
// 			throw new Error(
// 				`Failed to consume hub repair item '${requirement.item_name}': expected ${requirement.amount}, removed ${removed}.`,
// 			);
// 		}
// 	}
// };

// const ensureHubLifecycleEntities = (): HubLifecycleEntities => {
// 	const surface = requireSurface(names.surface);
// 	const force = requireForce(names.force);
// 	const existingHub = findExistingHub(surface, force);

// 	let destroyedHubContainer = findDestroyedHubContainer(surface);
// 	let destroyedHubRubble = findDestroyedHubRubble(surface);

// 	if (existingHub) {
// 		if (destroyedHubContainer || destroyedHubRubble) {
// 			throw new Error('Hub main entity and destroyed hub entities cannot coexist at the hub origin.');
// 		}

// 		syncHubParts(existingHub);
// 		return { surface, force, hub: existingHub };
// 	}

// 	if (!destroyedHubContainer && !destroyedHubRubble) {
// 		[destroyedHubContainer, destroyedHubRubble] = createDestroyedHub(surface, force);
// 	} else if (!destroyedHubContainer || !destroyedHubRubble) {
// 		throw new Error('Destroyed hub state is invalid: container and rubble must either both exist or both be absent.');
// 	}

// 	lockDestroyedHubContainer(destroyedHubContainer);
// 	configureDestroyedHubRubble(destroyedHubRubble);
// 	configureDestroyedHubContainer(destroyedHubContainer);
// 	return {
// 		surface,
// 		force,
// 		destroyedHubContainer,
// 		destroyedHubRubble,
// 	};
// };

// const updateHubLifecycle = () => {
// 	const { surface, force, hub, destroyedHubContainer, destroyedHubRubble } = ensureHubLifecycleEntities();
// 	if (hub) {
// 		destroyHubRepairStatusText();
// 		return hub;
// 	}

// 	if (!destroyedHubContainer || !destroyedHubRubble) {
// 		throw new Error('Destroyed hub lifecycle update requires both container and rubble entities.');
// 	}

// 	const [repairComplete, repairStatus] = collectHubRepairStatus(destroyedHubContainer);
// 	drawDestroyedHubRepairStatus(destroyedHubContainer, repairStatus);
// 	if (!repairComplete) return undefined;

// 	destroyHubRepairStatusText();
// 	consumeHubRepairItems(destroyedHubContainer);
// 	const leftoverStacks = snapshotInventoryStacks(
// 		requireInventory(
// 			destroyedHubContainer.get_inventory(defines.inventory.chest),
// 			'Missing destroyed hub container inventory.',
// 		),
// 	);
// 	destroyEntityOrFail(destroyedHubRubble, 'destroyed hub rubble');
// 	destroyEntityOrFail(destroyedHubContainer, 'destroyed hub container');
// 	const rebuiltHub = placeHub(surface, force);
// 	transferStacksToHubStorage(rebuiltHub, leftoverStacks);
// 	return rebuiltHub;
// };

// const destroyHubUi = (player: LuaPlayer) => {
// 	const relativeRoot = player.gui.relative[names.uiRoot];
// 	if (relativeRoot) {
// 		relativeRoot.destroy();
// 	}

// 	const screenRoot = player.gui.screen[names.uiRoot];
// 	if (screenRoot) {
// 		screenRoot.destroy();
// 	}
// };

// const ensureHubUi = (player: LuaPlayer) => {
// 	const existingRoot = player.gui.relative[names.uiRoot];
// 	if (existingRoot) return existingRoot;

// 	const root = player.gui.relative.add({
// 		type: 'frame',
// 		name: names.uiRoot,
// 		direction: 'vertical',
// 		caption: 'Hub',
// 		anchor: {
// 			gui: defines.relative_gui_type.cargo_landing_pad_gui,
// 			position: defines.relative_gui_position.right,
// 		},
// 	});
// 	root.style.width = 320;

// 	root.add({
// 		type: 'label',
// 		name: names.uiPowerLabel,
// 		caption: '',
// 	});

// 	const powerBar = root.add({
// 		type: 'progressbar',
// 		name: names.uiPowerBar,
// 		value: 0,
// 	});
// 	powerBar.style.horizontally_stretchable = true;

// 	const fluidTable = root.add({
// 		type: 'table',
// 		name: names.uiFluidTable,
// 		column_count: 4,
// 	});
// 	fluidTable.style.horizontal_spacing = 6;

// 	return root;
// };

// const requireGuiChild = (parent: LuaGuiElement, name: string) => {
// 	const child = parent[name];
// 	if (!child) throw new Error(`Missing GUI child '${name}'.`);
// 	return child;
// };

// const extractFluid = (entity: LuaEntity) => {
// 	const [fluidName, amount] = next(entity.get_fluid_contents()) as LuaMultiReturn<
// 		[string | undefined, number | undefined]
// 	>;
// 	return {
// 		fluidName,
// 		amount: amount ?? 0,
// 	};
// };

// const formatCompactInt = (value: number) => {
// 	let rounded = math.floor(value + 0.5);
// 	let sign = '';
// 	if (rounded < 0) {
// 		sign = '-';
// 		rounded = -rounded;
// 	}

// 	if (rounded >= 1_000_000) return `${sign}${math.floor(rounded / 1_000_000)}M`;
// 	if (rounded >= 1_000) return `${sign}${math.floor(rounded / 1_000)}k`;
// 	return `${sign}${rounded}`;
// };

// const resolveFluidBarColor = (fluidName: string) => {
// 	const baseColor = prototypes.fluid[fluidName]?.base_color;
// 	if (!baseColor) return { r: 0.35, g: 0.35, b: 0.35 };
// 	return { r: baseColor.r, g: baseColor.g, b: baseColor.b };
// };

// const addFluidRow = (fluidTable: LuaGuiElement, directionIcon: string, fluidPipe: LuaEntity) => {
// 	const { fluidName, amount } = extractFluid(fluidPipe);
// 	const capacity = fluidPipe.fluidbox.get_capacity(1);
// 	const amountRatio = capacity > 0 ? clamp01(amount / capacity) : 0;

// 	const directionCell = fluidTable.add({
// 		type: 'label',
// 		caption: directionIcon,
// 	});
// 	directionCell.style.minimal_width = 22;
// 	directionCell.style.maximal_width = 22;
// 	directionCell.style.horizontal_align = 'center';

// 	const fluidIconCell = fluidTable.add({
// 		type: 'label',
// 		caption: fluidName ? `[fluid=${fluidName}]` : names.uiFluidEmptyIcon,
// 	});
// 	fluidIconCell.style.minimal_width = 22;
// 	fluidIconCell.style.maximal_width = 22;
// 	fluidIconCell.style.horizontal_align = 'center';

// 	const fluidBar = fluidTable.add({
// 		type: 'progressbar',
// 		value: amountRatio,
// 	});
// 	fluidBar.style.minimal_width = 140;
// 	fluidBar.style.maximal_width = 140;
// 	fluidBar.style.color = resolveFluidBarColor(fluidName ?? '');

// 	const totalsCell = fluidTable.add({
// 		type: 'label',
// 		caption: `${formatCompactInt(amount)} / ${formatCompactInt(capacity)}`,
// 	});
// 	totalsCell.style.minimal_width = 88;
// 	totalsCell.style.maximal_width = 88;
// 	totalsCell.style.horizontal_align = 'right';
// 	totalsCell.style.font = 'default-mono';
// };

// const updateHubUi = (player: LuaPlayer, hubEntity: LuaEntity) => {
// 	syncHubParts(hubEntity);
// 	const root = ensureHubUi(player);

// 	const accumulator = findHubPart(hubEntity, names.hubAccumulator, { x: 0, y: 0 });
// 	const leftPipe = findHubPart(hubEntity, names.hubFluidPipe, hubPipeLeftOffset);
// 	const rightPipe = findHubPart(hubEntity, names.hubFluidPipe, hubPipeRightOffset);

// 	const energy = accumulator.energy ?? 0;
// 	const capacity = accumulator.electric_buffer_size ?? 0;

// 	const powerLabel = requireGuiChild(root, names.uiPowerLabel);
// 	powerLabel.caption = `Accumulator: ${string.format('%.1fMJ / %.1fMJ', energy / 1_000_000, capacity / 1_000_000)}`;

// 	const powerBar = requireGuiChild(root, names.uiPowerBar);
// 	(powerBar as unknown as { value: number }).value = capacity > 0 ? clamp01(energy / capacity) : 0;

// 	const fluidTable = requireGuiChild(root, names.uiFluidTable);
// 	fluidTable.clear();
// 	addFluidRow(fluidTable, names.uiFluidLeftIcon, leftPipe);
// 	addFluidRow(fluidTable, names.uiFluidRightIcon, rightPipe);
// };

// const resetOpenHubState = () => {
// 	openHubsByPlayer = {};
// };

// const clearOpenHubStateForPlayers = () => {
// 	for (const [, player] of pairs(game.players)) {
// 		destroyHubUi(player);
// 	}
// 	destroyHubRepairStatusText();
// 	resetOpenHubState();
// };

// const updateOpenHubUis = () => {
// 	for (const [playerIndex, hubEntity] of pairs(openHubsByPlayer)) {
// 		const index = playerIndex as PlayerIndex;
// 		const player = game.get_player(index);
// 		if (!player || !hubEntity?.valid || !isHubMain(hubEntity)) {
// 			openHubsByPlayer[index] = undefined;
// 			if (player) destroyHubUi(player);
// 			continue;
// 		}

// 		updateHubUi(player, hubEntity);
// 	}
// };

// const handleGuiOpened = (event: OnGuiOpenedEvent) => {
// 	const player = game.get_player(event.player_index);
// 	if (!player) return;

// 	const openedEntity = event.entity;
// 	if (!isHubMain(openedEntity)) {
// 		openHubsByPlayer[player.index] = undefined;
// 		destroyHubUi(player);
// 		return;
// 	}

// 	syncHubParts(openedEntity);
// 	openHubsByPlayer[player.index] = openedEntity;
// 	updateHubUi(player, openedEntity);
// };

// const handleGuiClosed = (event: OnGuiClosedEvent) => {
// 	const player = game.get_player(event.player_index);
// 	if (!player) return;
// 	openHubsByPlayer[player.index] = undefined;
// 	destroyHubUi(player);
// };

// const syncCreatedEntity = (entity: LuaEntity | undefined) => {
// 	if (isHubMain(entity)) {
// 		syncHubParts(entity);
// 	}
// };

// const cleanupDestroyedEntity = (entity: LuaEntity | undefined) => {
// 	if (isHubMain(entity)) {
// 		cleanupHubParts(entity);
// 	}
// };

// function init() {
// 	on_event('on_built_entity', event => syncCreatedEntity(event.entity));
// 	on_event('on_robot_built_entity', event => syncCreatedEntity(event.entity));
// 	on_event('script_raised_built', event => syncCreatedEntity(event.entity));
// 	on_event('script_raised_revive', event => syncCreatedEntity(event.entity));
// 	on_event('on_entity_cloned', event => syncCreatedEntity(event.destination));

// 	on_event('on_pre_player_mined_item', event => cleanupDestroyedEntity(event.entity));
// 	on_event('on_robot_pre_mined', event => cleanupDestroyedEntity(event.entity));
// 	on_event('on_entity_died', event => cleanupDestroyedEntity(event.entity));
// 	on_event('script_raised_destroy', event => cleanupDestroyedEntity(event.entity));

// 	on_event('on_gui_opened', handleGuiOpened);
// 	on_event('on_gui_closed', handleGuiClosed);

// 	script.on_init(() => {
// 		clearOpenHubStateForPlayers();
// 		updateHubLifecycle();
// 	});

// 	script.on_load(() => {
// 		destroyHubRepairStatusText();
// 		resetOpenHubState();
// 	});

// 	script.on_configuration_changed(() => {
// 		clearOpenHubStateForPlayers();
// 		updateHubLifecycle();
// 	});

// 	on_nth_tick(HUB_UI_UPDATE_INTERVAL, () => {
// 		updateHubLifecycle();
// 		updateOpenHubUis();
// 	});
// }

// init();
