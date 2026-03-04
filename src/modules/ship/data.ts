import * as util from 'util';
import { names, shipConnectorSizes, shipModuleIds, shipModules, ShipConnectorSize, ShipModuleId } from './constants';
import { shipModuleData } from './generated';
import { addTechnology, extend } from '@/lib/data-utils';

const hiddenOffGridFlags = ['placeable-neutral', 'placeable-off-grid', 'not-on-map'] as const;
const zeroBox = [
	[0, 0],
	[0, 0],
] as const;
const order = (segment: string) => `z[${names.ns()}]-${segment}`;
const connectorIcons = [
	{
		icon: '__base__/graphics/icons/cargo-landing-pad.png',
		icon_size: 64,
	},
	{
		icon: '__base__/graphics/icons/hazard-concrete.png',
		icon_size: 64,
		scale: 0.5,
		shift: [16, 16] as const,
	},
] as const;
const connectorTileSprite = (path: string, xShift: number, yShift: number) => ({
	filename: path,
	width: 64,
	height: 64,
	x: 0,
	y: 0,
	scale: 0.5,
	shift: [xShift, yShift] as const,
});
const connectorHazardLeftSprite = (xShift: number, yShift: number) =>
	connectorTileSprite('__base__/graphics/terrain/hazard-concrete-left/hazard-concrete-left.png', xShift, yShift);
const connectorHazardRightSprite = (xShift: number, yShift: number) =>
	connectorTileSprite('__base__/graphics/terrain/hazard-concrete-right/hazard-concrete-right.png', xShift, yShift);
const connectorTileOffsets = (size: ShipConnectorSize) => {
	const offsets: number[] = [];
	const firstOffset = -size / 2 + 0.5;
	for (let index = 0; index < size; index += 1) offsets.push(firstOffset + index);
	return offsets;
};
const connectorLayers = (size: ShipConnectorSize, orientation: 'horizontal' | 'vertical') => {
	const layers: Array<{
		filename: string;
		height: number;
		scale: number;
		width: number;
		shift: readonly [number, number];
	}> = [];
	const offsets = connectorTileOffsets(size);
	for (let index = 0; index < offsets.length; index += 1) {
		const offset = offsets[index]!;
		const sprite = index % 2 === 0 ? connectorHazardLeftSprite : connectorHazardRightSprite;
		if (orientation === 'horizontal') layers.push(sprite(offset, 0));
		else layers.push(sprite(0, offset));
	}
	return layers;
};
const connectorPicture = (size: ShipConnectorSize) => ({
	north: { layers: connectorLayers(size, 'horizontal') },
	south: { layers: connectorLayers(size, 'horizontal') },
	east: { layers: connectorLayers(size, 'vertical') },
	west: { layers: connectorLayers(size, 'vertical') },
});

const connectorSelectionBox = (size: ShipConnectorSize) =>
	[
		[-size / 2, -0.5],
		[size / 2, 0.5],
	] as const;
const makeConnectorEntity = (size: ShipConnectorSize) =>
	extend(
		data.raw['simple-entity-with-owner']['simple-entity-with-owner']!,
		{
			name: names.connectorEntity(size),
			icons: connectorIcons,
			collision_box: connectorSelectionBox(size),
			max_health: 1000,
			order: order(`c[connector-entity-${size}]`),
			picture: connectorPicture(size),
			render_layer: 'floor',
			selection_box: connectorSelectionBox(size),
			tile_width: size,
			tile_height: 1,
			minable: {
				mining_time: 1,
			},
			collision_mask: {
				layers: {
					[names.tileCollisionLayer]: true,
				},
			},
		},
		{
			remove: ['corpse', 'icon'],
		},
	);
const makeConnectorPlacementItem = (size: ShipConnectorSize) => {
	const item = extend(data.raw.item['hazard-concrete']!, {
		name: names.connectorPlacementItem(size),
		icons: connectorIcons,
		place_result: names.connectorPlacementEntity(size),
		hidden: true,
		hidden_in_factoriopedia: true,
		flags: ['only-in-cursor'] as const,
		subgroup: 'space-interactors',
		order: order(`c[connector-placement-item-${size}]`),
		stack_size: 1,
	});

	delete item.place_as_tile;
	delete item.icon;
	return item;
};
const makeConnectorPlacementEntity = (size: ShipConnectorSize) =>
	extend(
		data.raw['simple-entity-with-owner']['simple-entity-with-owner']!,
		{
			name: names.connectorPlacementEntity(size),
			icons: connectorIcons,
			collision_box: zeroBox,
			selection_box: zeroBox,
			hidden: true,
			hidden_in_factoriopedia: true,
			max_health: 1,
			order: order(`c[connector-placement-entity-${size}]`),
			render_layer: 'object',
			selectable_in_game: false,
			tile_width: size,
			tile_height: 1,
			flags: ['placeable-player', 'player-creation', 'not-on-map'] as const,
			allow_copy_paste: false,
			picture: connectorPicture(size),
		},
		{
			remove: ['icon', 'corpse', 'minable', 'placeable_position_visualization'],
		},
	);

const moduleIconPath = (moduleId: ShipModuleId) => shipModuleData[moduleId].icon;
const modulePlacementPreviewScale = (moduleId: ShipModuleId) => {
	const module = shipModuleData[moduleId];
	const maxSpan = math.max(module.width, module.height);
	const rasterTileSize = math.max(4, math.floor(52 / maxSpan));
	return 32 / rasterTileSize;
};
const makeModuleIconSprite = (moduleId: ShipModuleId) => ({
	type: 'sprite' as const,
	name: names.moduleIconSprite(moduleId),
	filename: moduleIconPath(moduleId),
	width: 64,
	height: 64,
	flags: ['gui-icon'] as const,
});
const makeModulePlacementItem = (moduleId: ShipModuleId) => {
	const item = extend(data.raw.item['hazard-concrete']!, {
		name: names.modulePlacementItem(moduleId),
		icons: [
			{
				icon: moduleIconPath(moduleId),
				icon_size: 64,
			},
		],
		place_result: names.modulePlacementEntity(moduleId),
		hidden: true,
		hidden_in_factoriopedia: true,
		flags: ['only-in-cursor'],
		subgroup: 'space-interactors',
		order: order(`m[module-placement-item-${moduleId}]`),
		stack_size: 1,
	});

	delete item.place_as_tile;
	delete item.icon;
	return item;
};
const makeModulePlacementEntity = (moduleId: ShipModuleId) => {
	const previewScale = modulePlacementPreviewScale(moduleId);
	const previews = shipModuleData[moduleId].previews;
	return extend(
		data.raw['simple-entity-with-owner']['simple-entity-with-owner']!,
		{
			name: names.modulePlacementEntity(moduleId),
			icons: [
				{
					icon: moduleIconPath(moduleId),
					icon_size: 64,
				},
			],
			collision_box: zeroBox,
			selection_box: zeroBox,
			hidden: true,
			hidden_in_factoriopedia: true,
			max_health: 1,
			order: order(`m[module-placement-entity-${moduleId}]`),
			render_layer: 'object',
			selectable_in_game: false,
			tile_width: 1,
			tile_height: 1,
			flags: ['placeable-player', 'player-creation', 'not-on-map'] as const,
			allow_copy_paste: false,
			picture: {
				north: {
					filename: previews.north,
					width: 64,
					height: 64,
					scale: previewScale,
				},
				east: {
					filename: previews.east,
					width: 64,
					height: 64,
					scale: previewScale,
				},
				south: {
					filename: previews.south,
					width: 64,
					height: 64,
					scale: previewScale,
				},
				west: {
					filename: previews.west,
					width: 64,
					height: 64,
					scale: previewScale,
				},
			},
		},
		{
			remove: ['icon', 'corpse', 'minable', 'placeable_position_visualization'],
		},
	);
};

const modulePlacementPrototypes: any[] = [];
for (const moduleId of shipModuleIds) {
	modulePlacementPrototypes.push(makeModuleIconSprite(moduleId));
	if (moduleId === 'hub') continue;
	modulePlacementPrototypes.push(makeModulePlacementEntity(moduleId));
	modulePlacementPrototypes.push(makeModulePlacementItem(moduleId));
}
const connectorPrototypes: any[] = [];
for (const connectorSize of shipConnectorSizes) {
	connectorPrototypes.push(makeConnectorEntity(connectorSize));
	connectorPrototypes.push(makeConnectorPlacementEntity(connectorSize));
	connectorPrototypes.push(makeConnectorPlacementItem(connectorSize));
}

const makeHubFluidPipe = () => {
	const clone = extend(
		data.raw['storage-tank']['storage-tank']!,
		{
			collision_box: [
				[-0.29, -0.29],
				[0.29, 0.29],
			],
			flags: ['placeable-neutral', 'placeable-player', 'player-creation'] as const,
			hidden: true,
			hidden_in_factoriopedia: true,
			icon: '__base__/graphics/icons/pipe.png',
			name: names.hubFluidPipe,
			order: order('d[hub-fluid-pipe]'),
			pictures: {
				flow_sprite: {
					filename: '__base__/graphics/entity/pipe/fluid-flow-low-temperature.png',
					height: 18,
					priority: 'extra-high',
					width: 160,
				},
				fluid_background: {
					filename: '__base__/graphics/entity/pipe/fluid-background.png',
					height: 40,
					priority: 'extra-high',
					scale: 0.5,
					width: 64,
				},
				gas_flow: {
					animation_speed: 0.25,
					filename: '__base__/graphics/entity/pipe/steam.png',
					frame_count: 60,
					height: 30,
					line_length: 10,
					priority: 'extra-high',
					scale: 0.5,
					width: 48,
				},
				picture: {
					filename: '__base__/graphics/entity/pipe/pipe-cross.png',
					height: 128,
					priority: 'extra-high',
					scale: 0.5,
					width: 128,
				},
				window_background: {
					filename: '__base__/graphics/entity/pipe/pipe-horizontal-window-background.png',
					height: 128,
					priority: 'extra-high',
					scale: 0.5,
					width: 128,
				},
			},
			selection_box: [
				[-0.5, -0.5],
				[0.5, 0.5],
			],
			two_direction_only: false,
			window_bounding_box: [
				[-0.25, -0.25],
				[0.25, 0.25],
			],
		},
		{
			remove: ['minable', 'fast_replaceable_group'],
		},
	);

	clone.fluid_box.volume = 2000;
	clone.fluid_box.pipe_connections = [
		{ direction: defines.direction.north, position: [0, 0] },
		{ direction: defines.direction.east, position: [0, 0] },
		{ direction: defines.direction.south, position: [0, 0] },
		{ direction: defines.direction.west, position: [0, 0] },
	];

	return clone;
};

const caragoLandingPad = extend(
	data.raw['cargo-landing-pad']['cargo-landing-pad'],
	{
		allow_copy_paste: false,
		hidden: true,
		hidden_in_factoriopedia: true,
		name: names.hubLandingPad,
		radar_range: 20,
	},
	{
		remove: ['minable'],
	},
);

for (const moduleId of shipModuleIds) {
	const { tech, expands } = shipModules[moduleId];
	if (moduleId === 'hub') {
		addTechnology({
			name: names.ns('module-hub'),
			icon: moduleIconPath(moduleId),
			icon_size: 64,
			localised_name: LOCALE('technology-name', 'ship-module-unlock', moduleId),
			localised_description: LOCALE('technology-description', 'ship-module-unlock'),
			prerequisites: [],
			research_trigger: {
				type: 'scripted',
			},
		});
		continue;
	}
	addTechnology({
		name: names.ns(`module-${moduleId}`),
		icon: moduleIconPath(moduleId),
		icon_size: 64,
		localised_name: LOCALE('technology-name', 'ship-module-unlock', moduleId),
		localised_description: LOCALE('technology-description', 'ship-module-unlock'),
		prerequisites: expands ? [names.ns(`module-${expands}`)] : [],
		unit: tech,
	});
}
for (const connectorSize of shipConnectorSizes)
	addTechnology({
		name: names.connectorTech(connectorSize),
		icon: '__base__/graphics/icons/hazard-concrete.png',
		icon_size: 64,
		localised_name: LOCALE('technology-name', 'ship-connector-unlock', connectorSize),
		localised_description: LOCALE('technology-description', 'ship-connector-unlock', connectorSize),
		prerequisites:
			connectorSize === 2 ? [names.ns('module-hub')] : [names.connectorTech((connectorSize - 1) as ShipConnectorSize)],
		unit: {
			count: connectorSize === 2 ? 20 : connectorSize === 3 ? 40 : 80,
			time: 15,
			ingredients: [['automation-science-pack', 1]],
		},
	});

data.extend([
	{
		name: names.tileCollisionLayer,
		type: 'collision-layer',
	},
	extend(data.raw.item['foundation'], {
		name: names.tile,
		hidden: true,
		hidden_in_factoriopedia: true,
		place_as_tile: {
			result: names.tile,
			condition: {
				layers: {},
			},
			condition_size: 1,
		},
	}),
	extend(
		data.raw.tile['foundation']!,
		{
			hidden: true,
			hidden_in_factoriopedia: true,
			name: names.tile,
			decorative_removal_probability: 1,
			collision_mask: {
				colliding_with_tiles_only: true,
				layers: {
					[names.tileCollisionLayer]: true,
				},
			},
		},
		{
			remove: ['minable'],
		},
	),
	...connectorPrototypes,
	makeHubFluidPipe(),
	...modulePlacementPrototypes,
	caragoLandingPad,
	extend(data.raw['electric-energy-interface']['hidden-electric-energy-interface'], {
		collision_box: zeroBox,
		energy_source: {
			buffer_capacity: '10MJ',
			input_flow_limit: '1MW',
			output_flow_limit: '1MW',
			type: 'electric',
			usage_priority: 'tertiary',
		},
		flags: hiddenOffGridFlags,
		gui_mode: 'none',
		hidden: true,
		hidden_in_factoriopedia: true,
		name: names.hubAccumulator,
		selectable_in_game: false,
		selection_box: zeroBox,
	}),
	extend(
		data.raw['electric-pole']['small-electric-pole'],
		{
			auto_connect_up_to_n_wires: 0,
			collision_box: zeroBox,
			flags: hiddenOffGridFlags,
			hidden: true,
			hidden_in_factoriopedia: true,
			maximum_wire_distance: 0,
			name: names.hubPowerPole,
			selectable_in_game: false,
			selection_box: zeroBox,
			supply_area_distance: 10,
		},
		{
			remove: ['minable', 'fast_replaceable_group'],
		},
	),
	extend(
		data.raw.container['wooden-chest'],
		{
			collision_box: caragoLandingPad.collision_box,
			flags: ['placeable-neutral', 'player-creation', 'not-deconstructable'],
			hidden: true,
			hidden_in_factoriopedia: true,
			icon: '__base__/graphics/icons/cargo-landing-pad.png',
			inventory_size: 20,
			inventory_type: 'with_filters_and_bar',
			max_health: 1,
			name: names.destroyedHub,
			picture: {
				layers: [
					{
						filename: '__base__/graphics/entity/cargo-hubs/hubs/planet-hub-remnants.png',
						height: 610,
						scale: 0.5,
						shift: util.by_pixel(-12, 5.5),
						width: 686,
					},
				],
			},
			selection_box: caragoLandingPad.selection_box,
		},
		{
			remove: ['minable', 'fast_replaceable_group'],
		},
	),
]);
