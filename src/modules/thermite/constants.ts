import { modNs } from '@/constants';

const ns = modNs.ns('thermite');

export const names = {
	ns,
	recipe: ns(''),
	item: ns(''),
	projectile: ns('projectile'),
} as const;
