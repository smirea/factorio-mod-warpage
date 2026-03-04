import { makeEnum, modNs, nsFactory } from '@/lib/constants';
import { TypedTechnologyUnit } from '@/types';
import { shipModuleData, ShipModuleData } from './generated';

const ns = nsFactory(modNs('ship'));

export const shipModuleIds = ['hub', 'box1', 'box2', 'box3', 'box4', 'uModule', 'iModule', 'tModule'] as const;
export type ShipModuleId = (typeof shipModuleIds)[number];
export const shipConnectorSizes = [2, 3, 4] as const;
export type ShipConnectorSize = (typeof shipConnectorSizes)[number];
/** the max amount of tiles a connector will extend. determines the max placement of modules */
export const connectorRange = 6;

export const placeableModules = shipModuleIds.filter(
	(moduleId): moduleId is Exclude<ShipModuleId, 'hub'> => moduleId !== 'hub',
);

export const names = {
	ns,
	connector: ns('connector'),
	connectorEntity: (size: ShipConnectorSize) => ns(`connector-${size}`),
	connectorPlacementEntity: (size: ShipConnectorSize) => ns(`connector-placement-entity-${size}`),
	connectorPlacementItem: (size: ShipConnectorSize) => ns(`connector-placement-item-${size}`),
	connectorTech: (size: ShipConnectorSize) => ns(`connector-size-${size}`),
	...makeEnum(ns(), [
		'destroyedHub',
		'hubAccumulator',
		'hubFluidPipe',
		'hubLandingPad',
		'hubPowerPole',
		// 'connectorRosterSection',
		// 'moduleRosterFrame',
		'tile',
		'tileCollisionLayer',
	]),
	modulePlacementEntity: (moduleId: ShipModuleId) => ns(`module-placement-entity-${moduleId}`),
	modulePlacementItem: (moduleId: ShipModuleId) => ns(`module-placement-item-${moduleId}`),
	moduleIconSprite: (moduleId: ShipModuleId) => ns(`module-icon-${moduleId}`),
} as const;

type ShipModuleDefinition = {
	blueprint: string;
	expands?: ShipModuleId;
	tech: TypedTechnologyUnit;
	connectors?: Array<{
		orientation: 'horizontal' | 'vertical';
		position: { x: number; y: number };
	}>;
};

export const shipModules: Record<ShipModuleId, ShipModuleDefinition> = {
	hub: {
		tech: { count: 1, time: 10, ingredients: [] },
		blueprint:
			'0eJyd2t1q20AQQOF3mWsZPLM/1upVSi7cVqQLjmwsp00xevfi7hoKhdI5t4bPZOHIw6xyl8+n9/lyrctNprvUL+dllenTXdb6uhxPj8+W49ssk/w4Xi/H13m3fquX3a2eZtkGqcvX+UMm3V4GeXzW7OW81ls9Lw/9IdM4yE+ZdmEb/vVdf7HCmO6hU+gMugBdhC5Bl6E7QAdzUdhL/zPNyUbGCmPPqN1OoTPoAnQRugRdhg7WojAXhb0Y7KUfT9nD4GWFsefD4HYKnUEXoIvQJegydLAWhbko7MVgL+14e/QseFVBqj8JbqaMGWOBschYYiwzxhpRFomySoxV0o7GRgGbBHAQwDkAxwCcAnAIwBkARwCcAHAAwN9/+PPPfv3ZWsC2ArgUwJ0ArgRwI4ALAdwH4DoAtwG4DMBdAK4CbBPwLtMjUgWpnj+854HXPPCWB17ywDseeMUDb3jgBQ+83/EyY5W0o0WUv1cVpHr+bqaMGWOBschYYiwzxhpRFomySoxV0o6WUP5eVZDq+buZMmaMBcYiY4mxzBhrRFkkyioxVkk7Wkb5e1VBqufvZsqYMRYYi4wlxjJjrBFlkSirxFgl7WgHlL9XFaR6/m6mjBljgbHIWGIsM8YaURaJskqMVdKONqL8vaog1fN3M2XMGAuMRcYSY5kx1oiySJRVYqySdrSC8veqglTP382UMWMsMBYZS4xlxlgjyiJRVomxSvq7CfYC182er7DgK1y/M+gCdBG6BF2G7gAdzEX/q5eXQeptfpPpj//SHOT7fF1/f1PKVmIpabR9ilG37Rdgy6RE',
	},
	box1: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd2t1q20AQQOF3mWsZPLM/1upVSi7cVqQLjmwsp00xevfi7hoKhdI5t4bPZOHIw6xyl8+n9/lyrctNprvUL+dllenTXdb6uhxPj8+W49ssk/w4Xi/H13m3fquX3a2eZtkGqcvX+UMm3V4GeXzW7OW81ls9Lw/9IdM4yE+ZdmEb/vVdf7HCmO6hU+gMugBdhC5Bl6E7QAdzUdhL/zPNyUbGCmPPqN1OoTPoAnQRugRdhg7WojAXhb0Y7KUfT9nD4GWFsefD4HYKnUEXoIvQJegydLAWhbko7MVgL+14e/QseFVBqj8JbqaMGWOBschYYiwzxhpRFomySoxV0o7GRgGbBHAQwDkAxwCcAnAIwBkARwCcAHAAwN9/+PPPfv3ZWsC2ArgUwJ0ArgRwI4ALAdwH4DoAtwG4DMBdAK4CbBPwLtMjUgWpnj+854HXPPCWB17ywDseeMUDb3jgBQ+83/EyY5W0o0WUv1cVpHr+bqaMGWOBschYYiwzxhpRFomySoxV0o6WUP5eVZDq+buZMmaMBcYiY4mxzBhrRFkkyioxVkk7Wkb5e1VBqufvZsqYMRYYi4wlxjJjrBFlkSirxFgl7WgHlL9XFaR6/m6mjBljgbHIWGIsM8YaURaJskqMVdKONqL8vaog1fN3M2XMGAuMRcYSY5kx1oiySJRVYqySdrSC8veqglTP382UMWMsMBYZS4xlxlgjyiJRVomxSvq7CfYC182er7DgK1y/M+gCdBG6BF2G7gAdzEX/q5eXQeptfpPpj//SHOT7fF1/f1PKVmIpabR9ilG37Rdgy6RE',
	},
	box2: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd2t1q20AQQOF3mWsZPLM/1upVSi7cVqQLjmwsp00xevfi7hoKhdI5t4bPZOHIw6xyl8+n9/lyrctNprvUL+dllenTXdb6uhxPj8+W49ssk/w4Xi/H13m3fquX3a2eZtkGqcvX+UMm3V4GeXzW7OW81ls9Lw/9IdM4yE+ZdmEb/vVdf7HCmO6hU+gMugBdhC5Bl6E7QAdzUdhL/zPNyUbGCmPPqN1OoTPoAnQRugRdhg7WojAXhb0Y7KUfT9nD4GWFsefD4HYKnUEXoIvQJegydLAWhbko7MVgL+14e/QseFVBqj8JbqaMGWOBschYYiwzxhpRFomySoxV0o7GRgGbBHAQwDkAxwCcAnAIwBkARwCcAHAAwN9/+PPPfv3ZWsC2ArgUwJ0ArgRwI4ALAdwH4DoAtwG4DMBdAK4CbBPwLtMjUgWpnj+854HXPPCWB17ywDseeMUDb3jgBQ+83/EyY5W0o0WUv1cVpHr+bqaMGWOBschYYiwzxhpRFomySoxV0o6WUP5eVZDq+buZMmaMBcYiY4mxzBhrRFkkyioxVkk7Wkb5e1VBqufvZsqYMRYYi4wlxjJjrBFlkSirxFgl7WgHlL9XFaR6/m6mjBljgbHIWGIsM8YaURaJskqMVdKONqL8vaog1fN3M2XMGAuMRcYSY5kx1oiySJRVYqySdrSC8veqglTP382UMWMsMBYZS4xlxlgjyiJRVomxSvq7CfYC182er7DgK1y/M+gCdBG6BF2G7gAdzEX/q5eXQeptfpPpj//SHOT7fF1/f1PKVmIpabR9ilG37Rdgy6RE',
	},
	box3: {
		expands: 'box1',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd2t1q20AQQOF3mWsZPLM/1upVSi7cVqQLjmwsp00xevfi7hoKhdI5t4bPZOHIw6xyl8+n9/lyrctNprvUL+dllenTXdb6uhxPj8+W49ssk/w4Xi/H13m3fquX3a2eZtkGqcvX+UMm3V4GeXzW7OW81ls9Lw/9IdM4yE+ZdmEb/vVdf7HCmO6hU+gMugBdhC5Bl6E7QAdzUdhL/zPNyUbGCmPPqN1OoTPoAnQRugRdhg7WojAXhb0Y7KUfT9nD4GWFsefD4HYKnUEXoIvQJegydLAWhbko7MVgL+14e/QseFVBqj8JbqaMGWOBschYYiwzxhpRFomySoxV0o7GRgGbBHAQwDkAxwCcAnAIwBkARwCcAHAAwN9/+PPPfv3ZWsC2ArgUwJ0ArgRwI4ALAdwH4DoAtwG4DMBdAK4CbBPwLtMjUgWpnj+854HXPPCWB17ywDseeMUDb3jgBQ+83/EyY5W0o0WUv1cVpHr+bqaMGWOBschYYiwzxhpRFomySoxV0o6WUP5eVZDq+buZMmaMBcYiY4mxzBhrRFkkyioxVkk7Wkb5e1VBqufvZsqYMRYYi4wlxjJjrBFlkSirxFgl7WgHlL9XFaR6/m6mjBljgbHIWGIsM8YaURaJskqMVdKONqL8vaog1fN3M2XMGAuMRcYSY5kx1oiySJRVYqySdrSC8veqglTP382UMWMsMBYZS4xlxlgjyiJRVomxSvq7CfYC182er7DgK1y/M+gCdBG6BF2G7gAdzEX/q5eXQeptfpPpj//SHOT7fF1/f1PKVmIpabR9ilG37Rdgy6RE',
	},
	box4: {
		expands: 'box2',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd2t1q20AQQOF3mWsZPLM/1upVSi7cVqQLjmwsp00xevfi7hoKhdI5t4bPZOHIw6xyl8+n9/lyrctNprvUL+dllenTXdb6uhxPj8+W49ssk/w4Xi/H13m3fquX3a2eZtkGqcvX+UMm3V4GeXzW7OW81ls9Lw/9IdM4yE+ZdmEb/vVdf7HCmO6hU+gMugBdhC5Bl6E7QAdzUdhL/zPNyUbGCmPPqN1OoTPoAnQRugRdhg7WojAXhb0Y7KUfT9nD4GWFsefD4HYKnUEXoIvQJegydLAWhbko7MVgL+14e/QseFVBqj8JbqaMGWOBschYYiwzxhpRFomySoxV0o7GRgGbBHAQwDkAxwCcAnAIwBkARwCcAHAAwN9/+PPPfv3ZWsC2ArgUwJ0ArgRwI4ALAdwH4DoAtwG4DMBdAK4CbBPwLtMjUgWpnj+854HXPPCWB17ywDseeMUDb3jgBQ+83/EyY5W0o0WUv1cVpHr+bqaMGWOBschYYiwzxhpRFomySoxV0o6WUP5eVZDq+buZMmaMBcYiY4mxzBhrRFkkyioxVkk7Wkb5e1VBqufvZsqYMRYYi4wlxjJjrBFlkSirxFgl7WgHlL9XFaR6/m6mjBljgbHIWGIsM8YaURaJskqMVdKONqL8vaog1fN3M2XMGAuMRcYSY5kx1oiySJRVYqySdrSC8veqglTP382UMWMsMBYZS4xlxlgjyiJRVomxSvq7CfYC182er7DgK1y/M+gCdBG6BF2G7gAdzEX/q5eXQeptfpPpj//SHOT7fF1/f1PKVmIpabR9ilG37Rdgy6RE',
	},
	uModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd18tqg1AUheF32WMDcenx9iolA9se0gNGRe0N8d2LjYNCofT8U5NPfhZ74mqP3asfp9Av1qwWnoZ+tuZhtTlc+7bbn/XtzVtj7+00tld/ml/CeFpC521LLPTP/sOadLsktj+723GYwxKGftf7r+fEPvc/JX+96zdLGRNiYpFikWKRx5JiS0YzISYWKRYpFnksmbElo5kQE4sUixSLPJbM2ZLRTIiJRYpFikUeSzq2ZDQTYmKRYpFikceSBVsymgkxsUixSLHIY8mSLRnNxFjGWM6YY6xgrGSsYqxGTOxKxK5E8ErukRU75WgmxjLGcsYcYwVjJWMVYzViYlcidiX6z5VcEguLv1nz41stsTc/zd8vcoXqvK5dpbPL83TbvgBQg4QQ',
	},
	iModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd1tGKwjAQheF3Odcp2DpVm1dZelE16EBNS1Ndl5J3l268WFhYNuc28IWfYQJZcOzvbpzUz7AL9DT4APuxIOjFd/165rubg8VnN43dxRXhqmMxa+8QDdSf3RO2jK3BepbsOASddfCrfsJKZfAFW2yj+euy325LOiHdu7MiO7OdkO7dWZKd2U5Ilzo3XGY2E46lSHKW5CjJSZKLSe4luZbkKycfOfnGhYvMZsKxFFlzkdlMOJYid1xkNhOOpcg9F5nNhGMp8sBFZjP5B2sNdHY32B/fA4OHm8L3RfWuaqRp6kO1qUXKGF/lobMi',
	},
	tModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eJyd1t+KhCAUx/F3OdcGZWrpqyxdNLsye6CxyOYf4bsvrXOxsDDg71b4+EU8WDudpqtfVg4buZ34cw6R3MdOkc9hnI61MF48ObqP6zKefRW/eak2njwlQRy+/INckwZBx1q2yxx54zkc+kFO14Ke5Ko2iXeb/XcN6CToWtAp0GnQGdB1oOtBZzFnwHkx6Ly8ehKcz2InQdeCToFOg86ArgNdDzqLOQPOi0Hn5XUPDXgPxS73aixXzHINPBx4NnCkwZsDH3jwe6KwWjHLNY3VilmuGaxWzHKtw2rFLNd6rPaeDYJ48xdyf/7zBN38Gn830kZaZa3uZa2ValL6AU5SRjQ=',
	},
};

const joinedData: Record<ShipModuleId, ShipModuleData & ShipModuleDefinition> = {} as any;
for (const [k, v] of Object.entries(shipModules)) {
	// @ts-ignore
	joinedData[k] = { ...v, ...shipModuleData[k] };
}

export function getShipModule(id: ShipModuleId): ShipModuleData & ShipModuleDefinition {
	if (joinedData[id] == null) throw new Error(`Invalid ship moduleId=${id}`);
	return joinedData[id];
}
