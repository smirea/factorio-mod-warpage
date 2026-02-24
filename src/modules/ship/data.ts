import { names } from './constants';
import { extend } from '@/lib/data-utils';
import { modNs } from '@/lib/constants';

const hiddenOffGridFlags = ['placeable-neutral', 'placeable-off-grid', 'not-on-map'] as const;
const zeroBox = [
	[0, 0],
	[0, 0],
] as const;
const order = (segment: string) => `z[${modNs()}]-${segment}`;

const makeHubFluidPipe = () => {
	const clone = extend(data.raw['storage-tank']['storage-tank']!, {
		name: names.hubFluidPipe,
		icon: '__base__/graphics/icons/pipe.png',
		flags: ['placeable-neutral', 'placeable-player', 'player-creation'] as const,
		hidden: true,
		hidden_in_factoriopedia: true,
		minable: undefined,
		fast_replaceable_group: undefined,
		collision_box: [
			[-0.29, -0.29],
			[0.29, 0.29],
		],
		selection_box: [
			[-0.5, -0.5],
			[0.5, 0.5],
		],
		two_direction_only: false,
		window_bounding_box: [
			[-0.25, -0.25],
			[0.25, 0.25],
		],
		pictures: {
			picture: {
				filename: '__base__/graphics/entity/pipe/pipe-cross.png',
				priority: 'extra-high',
				width: 128,
				height: 128,
				scale: 0.5,
			},
			fluid_background: {
				filename: '__base__/graphics/entity/pipe/fluid-background.png',
				priority: 'extra-high',
				width: 64,
				height: 40,
				scale: 0.5,
			},
			window_background: {
				filename: '__base__/graphics/entity/pipe/pipe-horizontal-window-background.png',
				priority: 'extra-high',
				width: 128,
				height: 128,
				scale: 0.5,
			},
			flow_sprite: {
				filename: '__base__/graphics/entity/pipe/fluid-flow-low-temperature.png',
				priority: 'extra-high',
				width: 160,
				height: 18,
			},
			gas_flow: {
				filename: '__base__/graphics/entity/pipe/steam.png',
				priority: 'extra-high',
				line_length: 10,
				width: 48,
				height: 30,
				frame_count: 60,
				animation_speed: 0.25,
				scale: 0.5,
			},
		},
		order: order('d[hub-fluid-pipe]'),
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
	name: names.hubLandingPad,
	minable: undefined,
	hidden_in_factoriopedia: true,
	hidden: true,
	allow_copy_paste: false,
	radar_range: 20,
});

data.extend([
	makeHubFluidPipe(),
	caragoLandingPad,
	extend(data.raw.accumulator.accumulator, {
		name: names.hubAccumulator,
		flags: hiddenOffGridFlags,
		hidden: true,
		hidden_in_factoriopedia: true,
		selectable_in_game: false,
		minable: undefined,
		fast_replaceable_group: undefined,
		collision_box: zeroBox,
		selection_box: zeroBox,
		chargable_graphics: undefined,
		water_reflection: undefined,
		working_sound: undefined,
		open_sound: undefined,
		close_sound: undefined,
		draw_copper_wires: false,
		draw_circuit_wires: false,
		order: order('a[hub-accumulator]'),
	}),
	extend(data.raw['electric-pole']['small-electric-pole'], {
		name: names.hubPowerPole,
		flags: hiddenOffGridFlags,
		hidden: true,
		hidden_in_factoriopedia: true,
		selectable_in_game: false,
		minable: undefined,
		fast_replaceable_group: undefined,
		collision_box: zeroBox,
		selection_box: zeroBox,
		maximum_wire_distance: 0,
		supply_area_distance: 10,
		auto_connect_up_to_n_wires: 0,
		draw_copper_wires: false,
		draw_circuit_wires: false,
	}),
	// extend(data.raw.roboport.roboport, {
	// 	name: names.hubRoboport,
	// 	flags: hiddenOffGridFlags,
	// 	hidden: true,
	// 	hidden_in_factoriopedia: true,
	// 	selectable_in_game: false,
	// 	minable: undefined,
	// 	fast_replaceable_group: undefined,
	// 	collision_box: zeroBox,
	// 	selection_box: zeroBox,
	// 	order: order('c[hub-roboport]'),
	// }),
	// extend(data.raw.corpse['cargo-landing-pad-remnants'], {
	// 	name: names.destroyedHubRubble,
	// 	time_before_removed: 60 * 60 * 24 * 365 * 100,
	// 	time_before_shading_off: 60 * 60 * 24 * 365 * 100,
	// 	expires: false,
	// 	remove_on_entity_placement: false,
	// 	remove_on_tile_placement: false,
	// 	selectable_in_game: false,
	// 	flags: ['placeable-neutral', 'placeable-off-grid', 'not-on-map', 'not-selectable-in-game'] as const,
	// 	order: order('f[destroyed-hub-rubble]'),
	// }),
]);
