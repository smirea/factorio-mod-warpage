import { names } from './constants';
import type { CapsulePrototype, IconData, RecipePrototype } from 'factorio:prototype';
import { addTechnology, extend, disableRecipe, disableTechnology, hideItem } from '@/lib/data-utils';

const barrelIcon = DIR_PATH_JOIN('./graphics/thermite-barrel.png');

function makeTechnologyIcons(overlayIcon: string, effectIcon = false) {
	const shift = effectIcon ? 12.5 : 50;
	return [
		{
			icon: barrelIcon,
			icon_size: 256,
		},
		{
			icon: overlayIcon,
			icon_size: 128,
			scale: effectIcon ? 0.25 : 0.5,
			shift: [shift, shift],
			floating: true,
		},
	] satisfies Array<IconData>;
}

const addRadiusTechnology = (level: number, count: number, ingredients: Array<[string, number]>) =>
	addTechnology({
		type: 'technology',
		name: names.ns('mining-radius-' + level),
		localised_name: LOCALE('technology-name', 'thermite-mining-radius', level),
		localised_description: LOCALE('technology-description', 'thermite-mining-radius'),
		icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-range.png'),
		effects: [
			{
				type: 'nothing',
				icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-range.png', true),
				use_icon_overlay_constant: false,
				effect_description: LOCALE('technology-effect', 'thermite-mining-radius', level),
			},
		],
		prerequisites: level === 1 ? [names.recipe] : [names.recipe, names.ns('mining-radius-' + (level - 1))],
		unit: {
			count,
			ingredients,
			time: 10,
		},
		upgrade: true,
	});

addTechnology({
	type: 'technology',
	name: names.recipe,
	icon: barrelIcon,
	icon_size: 256,
	effects: [{ type: 'unlock-recipe', recipe: names.recipe }],
	research_trigger: {
		type: 'mine-entity',
		entity: 'iron-ore',
	},
});
addTechnology({
	type: 'technology',
	name: names.miningProductivityRecipe,
	localised_name: LOCALE('technology-name', 'thermite-mining-productivity'),
	localised_description: LOCALE('technology-description', 'thermite-mining-productivity'),
	icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-capacity.png'),
	max_level: 5,
	effects: [
		{
			type: 'nothing',
			icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-capacity.png', true),
			use_icon_overlay_constant: false,
			effect_description: LOCALE('technology-effect', 'thermite-mining-productivity'),
		},
	],
	prerequisites: [names.recipe],
	unit: {
		ingredients: [['automation-science-pack', 1]],
		time: 10,
		count_formula: '100 * L',
	},
	upgrade: true,
});
addRadiusTechnology(1, 500, [['automation-science-pack', 1]]);
addRadiusTechnology(2, 500, [['logistic-science-pack', 1]]);
addRadiusTechnology(3, 500, [['chemical-science-pack', 1]]);

data.extend([
	{
		type: 'recipe',
		name: names.recipe,
		enabled: false,
		energy_required: 1,
		ingredients: [
			{ type: 'item', name: 'iron-plate', amount: 1 },
			{ type: 'item', name: 'copper-plate', amount: 1 },
			{ type: 'item', name: 'calcite', amount: 1 },
		],
		results: [{ type: 'item', name: names.item, amount: 1 }],
		subgroup: data.raw.item['electric-mining-drill']!.subgroup,
		order: data.raw.item['electric-mining-drill']!.order,
		allow_as_intermediate: false,
	} satisfies RecipePrototype,

	extend(data.raw.projectile.grenade, {
		name: names.projectile,
		action: [
			{
				type: 'direct',
				action_delivery: {
					type: 'instant',
					target_effects: [
						{
							type: 'script',
							effect_id: names.projectile,
						},
					],
				},
			},
		],
	}),

	{
		type: 'capsule',
		name: names.item,
		icon: barrelIcon,
		icon_size: 256,
		capsule_action: {
			type: 'throw',
			attack_parameters: {
				type: 'projectile',
				activation_type: 'throw',
				ammo_category: 'grenade',
				cooldown: 25,
				projectile_creation_distance: 0.6,
				range: 15,
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
			},
		},
		stack_size: 20,
		subgroup: data.raw.item['electric-mining-drill']!.subgroup,
		order: data.raw.item['electric-mining-drill']!.order,
	} satisfies CapsulePrototype,
]);

for (const key in data.raw.technology) {
	if (key.startsWith('mining-productivity')) disableTechnology(key);
}

disableRecipe('burner-mining-drill');
disableRecipe('electric-mining-drill');
disableTechnology('electric-mining-drill');
hideItem('burner-mining-drill');
hideItem('electric-mining-drill');
