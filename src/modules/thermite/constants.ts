import { modNs, nsFactory } from '@/constants';

const ns = nsFactory(modNs('thermite'));

export const names = {
	ns,
	recipe: ns(),
	item: ns(),
	projectile: ns('projectile'),
} as const;
