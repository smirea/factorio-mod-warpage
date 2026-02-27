import { names } from './constants';
import type { CapsulePrototype, IconData, RecipePrototype } from 'factorio:prototype';
import { addTechnology, disableRecipe, disableTechnology, extend, hideItem } from '@/lib/data-utils';
import { SciencePack } from '@/types';

const barrelIcon = DIR_PATH_JOIN('./graphics/thermite-barrel.png');

function makeTechnologyIcons(overlayIcon: string, effectIcon = false) {
	const shift = effectIcon ? 12.5 : 50;
	return [
		{
			icon: barrelIcon,
			icon_size: 256,
		},
		{
			floating: true,
			icon: overlayIcon,
			icon_size: 128,
			scale: effectIcon ? 0.25 : 0.5,
			shift: [shift, shift],
		},
	] satisfies IconData[];
}

const addRadiusTechnology = (level: number, count: number, ingredients: [SciencePack, number][]) =>
	addTechnology({
		name: names.ns('mining-radius-' + level),
		effects: [
			{
				effect_description: LOCALE('technology-effect', 'thermite-mining-radius', level),
				icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-range.png', true),
				type: 'nothing',
				use_icon_overlay_constant: false,
			},
		],
		icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-range.png'),
		localised_description: LOCALE('technology-description', 'thermite-mining-radius'),
		localised_name: LOCALE('technology-name', 'thermite-mining-radius', level),
		prerequisites: level === 1 ? [names.item] : [names.item, names.ns('mining-radius-' + (level - 1))],
		unit: {
			count,
			ingredients,
			time: 10,
		},
		upgrade: true,
	});

addTechnology({
	effects: [{ recipe: names.item, type: 'unlock-recipe' }],
	icon: barrelIcon,
	icon_size: 256,
	name: names.item,
	research_trigger: {
		entity: 'iron-ore',
		type: 'mine-entity',
	},
});
addTechnology({
	effects: [
		{
			effect_description: LOCALE('technology-effect', 'thermite-mining-productivity'),
			icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-capacity.png', true),
			type: 'nothing',
			use_icon_overlay_constant: false,
		},
	],
	icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-capacity.png'),
	localised_description: LOCALE('technology-description', 'thermite-mining-productivity'),
	localised_name: LOCALE('technology-name', 'thermite-mining-productivity'),
	max_level: 5,
	name: names.miningProductivityRecipe,
	prerequisites: [names.item],
	unit: {
		count_formula: '100 * L',
		ingredients: [['automation-science-pack', 1]],
		time: 10,
	},
	upgrade: true,
});
addRadiusTechnology(1, 500, [['automation-science-pack', 1]]);
addRadiusTechnology(2, 500, [['logistic-science-pack', 1]]);
addRadiusTechnology(3, 500, [['chemical-science-pack', 1]]);

data.extend([
	{
		allow_as_intermediate: false,
		enabled: false,
		energy_required: 1,
		ingredients: [
			{ amount: 1, name: 'iron-plate', type: 'item' },
			{ amount: 1, name: 'copper-plate', type: 'item' },
			{ amount: 1, name: 'calcite', type: 'item' },
		],
		name: names.item,
		order: data.raw.item['electric-mining-drill']!.order,
		results: [{ amount: 1, name: names.item, type: 'item' }],
		subgroup: data.raw.item['electric-mining-drill']!.subgroup,
		type: 'recipe',
	} satisfies RecipePrototype,

	extend(data.raw.projectile.grenade, {
		action: [
			{
				action_delivery: {
					target_effects: [
						{
							type: 'script',
							effect_id: names.projectile,
						},
					],
					type: 'instant',
				},
				type: 'direct',
			},
		],
		name: names.projectile,
	}),

	{
		capsule_action: {
			attack_parameters: {
				activation_type: 'throw',
				ammo_category: 'grenade',
				ammo_type: {
					target_type: 'position',
					action: {
						type: 'direct',
						action_delivery: {
							type: 'projectile',
							projectile: names.projectile,
							starting_speed: 0.3,
						},
					},
				},
				cooldown: 25,
				projectile_creation_distance: 0.6,
				range: 15,
				type: 'projectile',
			},
			type: 'throw',
		},
		icon: barrelIcon,
		icon_size: 256,
		name: names.item,
		order: data.raw.item['electric-mining-drill']!.order,
		stack_size: 20,
		subgroup: data.raw.item['electric-mining-drill']!.subgroup,
		type: 'capsule',
	} satisfies CapsulePrototype,
]);

for (const key in data.raw.technology) if (key.startsWith('mining-productivity')) disableTechnology(key);

disableRecipe('burner-mining-drill');
disableRecipe('electric-mining-drill');
disableTechnology('electric-mining-drill');
hideItem('burner-mining-drill');
hideItem('electric-mining-drill');
