import { modNs, nsFactory } from '@/lib/constants';

const ns = nsFactory(modNs('thermite'));

export const names = {
	ns,
	recipe: ns(),
	item: ns(),
	projectile: ns('projectile'),
	miningProductivityRecipe: ns('mining-productivity'),
} as const;
