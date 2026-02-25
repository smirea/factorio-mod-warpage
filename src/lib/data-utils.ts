// can be safely used in the data stage

import * as util from 'util';
import type { TechnologyPrototype } from 'factorio:prototype';

const itemTechnology: Record<string, string> = {};
let itemTechnologyLoaded = false;

function loadItemTechnologyMap() {
	if (itemTechnologyLoaded) return;
	itemTechnologyLoaded = true;

	for (const technologyName in data.raw.technology) {
		const technology = data.raw.technology[technologyName];
		if (!technology) continue;

		for (const effect of technology.effects || []) {
			if (effect.type !== 'unlock-recipe') continue;

			const recipe = data.raw.recipe[effect.recipe];
			if (!recipe) continue;

			for (const result of recipe.results || []) {
				if (result.type !== 'item') continue;
				if (itemTechnology[result.name]) continue;
				itemTechnology[result.name] = technology.name;
			}
		}
	}
}

export function extend<T extends Record<string, any> | undefined>(
	base: T,
	diff?: Partial<NonNullable<T>>,
): NonNullable<T> {
	if (!base) throw new Error('must pass a table');

	const clone = util.copy(base);
	if (!clone) throw new Error('util.copy() failed');

	if (diff) Object.assign(clone, diff);

	return clone;
}

export function addTechnology<const T extends TechnologyPrototype>(item: T): T {
	const icons = item.icons ? [...item.icons] : [];
	if (icons.length === 0) {
		if (!item.icon || !item.icon_size) {
			throw new Error(`technology ${item.name} must define icons or both icon and icon_size`);
		}
		icons.push({
			icon: item.icon,
			icon_size: item.icon_size,
		});
	}
	item = { ...item };
	delete item.icon;
	delete item.icon_size;
	icons.push({
		icon: '__base__/graphics/icons/signal/signal-heart.png',
		icon_size: 64,
		floating: true,
		shift: [-50, -50],
		scale: 0.6,
	});
	item = {
		...item,
		icons,
	};

	loadItemTechnologyMap();
	const prerequisites = item.prerequisites ? [...item.prerequisites] : [];

	for (const [name] of item.unit?.ingredients || []) {
		const technologyName = itemTechnology[name];
		if (!technologyName) continue;
		if (prerequisites.includes(technologyName)) continue;
		prerequisites.push(technologyName);
	}

	if (prerequisites.length > 0) item.prerequisites = prerequisites;

	data.extend([item]);
	return item;
}

export function disableRecipe(name: keyof typeof data.raw.recipe) {
	const recipe = data.raw.recipe[name];
	if (!recipe) return;
	recipe.enabled = false;
	recipe.hidden = true;
	recipe.hidden_in_factoriopedia = true;
	recipe.hide_from_player_crafting = true;
	recipe.hide_from_stats = true;
	recipe.hide_from_signal_gui = true;
	recipe.hide_from_bonus_gui = true;
	recipe.unlock_results = false;
}

export function disableTechnology(name: keyof typeof data.raw.technology) {
	const technology = data.raw.technology[name];
	if (!technology) return;
	technology.enabled = false;
	technology.visible_when_disabled = false;
	technology.hidden = true;
	technology.prerequisites = [];
}

export function hideItem(name: keyof typeof data.raw.item) {
	const item = data.raw.item[name];
	if (!item) return;
	item.hidden = true;
	item.hidden_in_factoriopedia = true;
}
