import * as util from 'util';
import { names } from './constants';
import { extend } from '@/lib/data-utils';
import { modNs } from '@/lib/constants';

const hiddenOffGridFlags = ['placeable-neutral', 'placeable-off-grid', 'not-on-map'] as const;
const zeroBox = [
	[0, 0],
	[0, 0],
] as const;
const order = (segment: string) => `z[${modNs()}]-${segment}`;

const makeShipTile = () => {
	const clone = extend(data.raw.tile['foundation']!, {
		hidden: true,
		hidden_in_factoriopedia: true,
		minable: undefined,
		name: names.tile,
		order: order('a[ship-tile]'),
	});

	clone.collision_mask = {
		...(clone.collision_mask ?? { layers: {} }),
		layers: {
			...clone.collision_mask?.layers,
			[names.tileCollisionLayer]: true,
		},
	};

	return clone;
};

const applyShipTileBuildabilityRule = () => {
	const requiredTiles = {
		layers: {
			[names.tileCollisionLayer]: true as const,
		},
	};
	const rawByType = data.raw as Record<string, Record<string, any> | undefined>;
	const placeableEntityNames: Record<string, true | undefined> = {};

	for (const prototypesByName of Object.values(rawByType)) {
		if (!prototypesByName) continue;

		for (const prototype of Object.values(prototypesByName)) {
			if (typeof prototype?.place_result !== 'string') continue;

			placeableEntityNames[prototype.place_result] = true;
		}
	}

	for (const prototypesByName of Object.values(rawByType)) {
		if (!prototypesByName) continue;

		for (const prototype of Object.values(prototypesByName)) {
			if (!prototype?.name || !prototype.collision_box) continue;

			if (!placeableEntityNames[prototype.name]) continue;

			prototype.tile_buildability_rules = [
				...(prototype.tile_buildability_rules ?? []),
				{
					area: prototype.collision_box,
					required_tiles: requiredTiles,
				},
			];
		}
	}
};

const makeHubFluidPipe = () => {
	const clone = extend(data.raw['storage-tank']['storage-tank']!, {
		collision_box: [
			[-0.29, -0.29],
			[0.29, 0.29],
		],
		fast_replaceable_group: undefined,
		flags: ['placeable-neutral', 'placeable-player', 'player-creation'] as const,
		hidden: true,
		hidden_in_factoriopedia: true,
		icon: '__base__/graphics/icons/pipe.png',
		minable: undefined,
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
	});

	clone.fluid_box.volume = 2000;
	clone.fluid_box.pipe_connections = [
		{ direction: defines.direction.north, position: [0, 0] },
		{ direction: defines.direction.east, position: [0, 0] },
		{ direction: defines.direction.south, position: [0, 0] },
		{ direction: defines.direction.west, position: [0, 0] },
	];

	return clone;
};

const caragoLandingPad = extend(data.raw['cargo-landing-pad']['cargo-landing-pad'], {
	allow_copy_paste: false,
	hidden: true,
	hidden_in_factoriopedia: true,
	minable: undefined,
	name: names.hubLandingPad,
	radar_range: 20,
});

data.extend([
	{
		name: names.tileCollisionLayer,
		type: 'collision-layer',
	},
	makeShipTile(),
	makeHubFluidPipe(),
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
	extend(data.raw['electric-pole']['small-electric-pole'], {
		auto_connect_up_to_n_wires: 0,
		collision_box: zeroBox,
		fast_replaceable_group: undefined,
		flags: hiddenOffGridFlags,
		hidden: true,
		hidden_in_factoriopedia: true,
		maximum_wire_distance: 0,
		minable: undefined,
		name: names.hubPowerPole,
		selectable_in_game: false,
		selection_box: zeroBox,
		supply_area_distance: 10,
	}),
	extend(data.raw.container['wooden-chest'], {
		collision_box: caragoLandingPad.collision_box,
		fast_replaceable_group: undefined,
		flags: ['placeable-neutral', 'player-creation', 'not-deconstructable'],
		hidden: true,
		hidden_in_factoriopedia: true,
		icon: '__base__/graphics/icons/cargo-landing-pad.png',
		inventory_size: 20,
		inventory_type: 'with_filters_and_bar',
		max_health: 1,
		minable: undefined,
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
	}),
]);

applyShipTileBuildabilityRule();
