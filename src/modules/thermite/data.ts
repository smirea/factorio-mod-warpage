import { modNs } from '@/lib/constants';
import { names } from './constants';
import type { SimpleEntityWithOwnerPrototype, CapsulePrototype, IconData, RecipePrototype } from 'factorio:prototype';
import { disableRecipe, disableTechnology, hideItem } from '@/lib/utils';
import { addTechnology, extend } from '@/lib/data-utils';

const barrelIcon = DIR_PATH_JOIN('./graphics/thermite-barrel.png');

function makeTechnologyIcons(overlayIcon: string) {
	return [
		{
			icon: barrelIcon,
			icon_size: 256,
		},
		{
			icon: overlayIcon,
			icon_size: 128,
			scale: 0.5,
			shift: [50, 50],
			floating: true,
		},
	] satisfies Array<IconData>;
}

const addProductivityTechnology = (level: number) =>
	addTechnology({
		type: 'technology',
		name: names.ns('mining-productivity-' + level),
		localised_name: LOCALE('technology-name', 'warpage-thermite-mining-productivity', level),
		localised_description: LOCALE('technology-description', 'warpage-thermite-mining-productivity'),
		icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-capacity.png'),
		effects: [
			{
				type: 'nothing',
				effect_description: LOCALE('technology-effect', 'warpage-thermite-mining-productivity', level),
			},
		],
		prerequisites: level === 1 ? [names.recipe] : [names.recipe, names.ns('mining-productivity-' + (level - 1))],
		unit: {
			count: level * 100,
			ingredients: [['automation-science-pack', 1]],
			time: 10,
		},
		upgrade: true,
	});

const addRadiusTechnology = (level: number, count: number, ingredients: Array<[string, number]>) =>
	addTechnology({
		type: 'technology',
		name: names.ns('mining-radius-' + level),
		localised_name: LOCALE('technology-name', 'warpage-thermite-mining-radius', level),
		localised_description: LOCALE('technology-description', 'warpage-thermite-mining-radius'),
		icons: makeTechnologyIcons('__core__/graphics/icons/technology/constants/constant-range.png'),
		effects: [
			{
				type: 'nothing',
				effect_description: LOCALE('technology-effect', 'warpage-thermite-mining-radius', level),
			},
		],
		prerequisites: level === 1 ? [names.recipe] : [names.recipe, names.ns('mining-radius-' + (level - 1))],
		unit: {
			count,
			ingredients,
			time: 30,
		},
		upgrade: true,
	});

for (const key in data.raw.technology) {
	if (key.startsWith('mining-productivity')) disableTechnology(key);
}

disableRecipe('burner-mining-drill');
disableRecipe('electric-mining-drill');
disableTechnology('electric-mining-drill');
hideItem('burner-mining-drill');
hideItem('electric-mining-drill');

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
addProductivityTechnology(1);
addProductivityTechnology(2);
addProductivityTechnology(3);
addProductivityTechnology(4);
addProductivityTechnology(5);
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
		light: undefined,
	}),

	{
		type: 'capsule',
		name: modNs('thermite'),
		icon: barrelIcon,
		icon_size: 256,
		capsule_action: {
			type: 'throw',
			attack_parameters: {
				type: 'projectile',
				activation_type: 'throw',
				ammo_category: 'grenade',
				cooldown: 20,
				projectile_creation_distance: 0.6,
				range: 20,
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
		subgroup: 'capsule',
		order: data.raw['mining-drill']['electric-mining-drill']?.order,
		stack_size: 100,
	} satisfies CapsulePrototype,

	{
		type: 'simple-entity-with-owner',
		name: names.ns('tooltip-anchor'),
		icon: barrelIcon,
		icon_size: 256,
		flags: [
			'not-on-map',
			'placeable-off-grid',
			'not-selectable-in-game',
			'not-deconstructable',
			'not-blueprintable',
			'not-upgradable',
			'not-flammable',
			'not-repairable',
			'no-copy-paste',
			'no-automated-item-removal',
			'no-automated-item-insertion',
			'not-in-kill-statistics',
			'get-by-unit-number',
		],
		hidden: true,
		selectable_in_game: false,
		allow_copy_paste: false,
		is_military_target: false,
		alert_when_damaged: false,
		max_health: 1,
		collision_mask: { layers: {} },
		collision_box: [
			[0, 0],
			[0, 0],
		],
		selection_box: [
			[0, 0],
			[0, 0],
		],
		render_layer: 'object',
		picture: {
			filename: '__core__/graphics/empty.png',
			size: 1,
		},
	} satisfies SimpleEntityWithOwnerPrototype,
]);
