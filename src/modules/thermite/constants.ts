import { modNs, nsFactory } from '@/lib/constants';

const ns = nsFactory(modNs('thermite'));

export const names = {
	item: ns(),
	miningProductivityRecipe: ns('mining-productivity'),
	ns,
	projectile: ns('projectile'),
	recipe: ns(),
} as const;
