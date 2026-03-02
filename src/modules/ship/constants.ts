import { modNs, nsFactory } from '@/lib/constants';
import { TypedTechnologyUnit } from '@/types';

const ns = nsFactory(modNs('ship'));

export const shipModuleIds = ['hub', 'box1', 'box2', 'box3', 'box4', 'uModule', 'iModule', 'tModule'] as const;
export type ShipModuleId = (typeof shipModuleIds)[number];

export const names = {
	ns,
	connector: ns('connector'),
	destroyedHub: ns('destroyed-hub-container'),
	hubAccumulator: ns('hub-accumulator'),
	hubFluidPipe: ns('hub-fluid-pipe'),
	hubLandingPad: ns('hub-landing-pad'),
	hubPowerPole: ns('hub-power-pole'),
	modulePlacementEntity: (moduleId: ShipModuleId) => ns(`module-placement-entity-${moduleId}`),
	modulePlacementItem: (moduleId: ShipModuleId) => ns(`module-placement-item-${moduleId}`),
	moduleIconSprite: (moduleId: ShipModuleId) => ns(`module-icon-${moduleId}`),
	moduleRosterFrame: ns('module-roster-frame'),
	moduleRosterFlow: ns('module-roster-flow'),
	moduleRosterButton: (moduleId: ShipModuleId) => ns(`module-roster-button-${moduleId}`),
	tile: ns('tile'),
	tileCollisionLayer: ns('tile-collision-layer'),
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
			'0eNqV2t9qU0EQB+B32esIOyf7N68ivag2yoE2KSYVpeTdjbXihQr9bk92Dgn7MfyGyXP6cP+0f/yyHs5p95zWj8fDKe3eP6fT+vlwe//z2eH2YZ926dPx6XB3e16Ph3TZpPVwt/+WdnG52aTzer//VfR4PK0vJ65l10/HJn1Pu3fb6/l/veSv8xPPR9aC0IJFC7ZaULSgakHTgq4FetGhN/36jZa3nh94fuL53/IWlbeovEXlLSpvUXmLyltU3qLyFpX35oJFb/r1JwRSDaQaSjWUaijVUKqhVEOphlINpRpKNZRqKNUwqtmkZoOa0WlGphmVZkSa0WhGohmFZgSa0WdGnhl1ZsOJbRS7qDZR7aHaQrWDagPV/qntU7unNk/tndo6sXNiHMU0qmFUs6hGUU2iGkQ1h2oM1RSqIVQzqEZQTKBbw4lDus7oOqLrhK4Dus7nOp7rdK7Duc7mOppvESdO8sVwFsNZEGdBnAVxFsRZEGdBnAVxFsRZEGdBnAVxFsNZDWc1nBVxVsRZEWdFnBVxVsRZEWdFnBVxVsRZEWc1nM1wNsPZEGdDnA1xNsTZEGdDnA1xNsTZEGdDnA1xNsPZDWc3nB1xdsTZEWdHnB1xdsTZEWdHnB1xdsTZEWc3nMNwDsM5EOdAnANxDsQ5EOdAnANxDsQ5EOdAnANxDsM5Dec0nBNxTsQ5EedEnBNxTsQ5EedEnBNxTsQ5ESdqC9z5hC59Qrc+oWuf0L1P6OIndPMTuvoJ3f2ELn9Ctz//K7jZpPW8f7g+/fP3ok36uv9yenlFbcssc9ax5FpKXC4/AJJn0Lo=',
	},
	box1: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV2t9qU0EQB+B32esIOyf7N68ivag2yoE2KSYVpeTdjbXihQr9bk92Dgn7MfyGyXP6cP+0f/yyHs5p95zWj8fDKe3eP6fT+vlwe//z2eH2YZ926dPx6XB3e16Ph3TZpPVwt/+WdnG52aTzer//VfR4PK0vJ65l10/HJn1Pu3fb6/l/veSv8xPPR9aC0IJFC7ZaULSgakHTgq4FetGhN/36jZa3nh94fuL53/IWlbeovEXlLSpvUXmLyltU3qLyFpX35oJFb/r1JwRSDaQaSjWUaijVUKqhVEOphlINpRpKNZRqKNUwqtmkZoOa0WlGphmVZkSa0WhGohmFZgSa0WdGnhl1ZsOJbRS7qDZR7aHaQrWDagPV/qntU7unNk/tndo6sXNiHMU0qmFUs6hGUU2iGkQ1h2oM1RSqIVQzqEZQTKBbw4lDus7oOqLrhK4Dus7nOp7rdK7Duc7mOppvESdO8sVwFsNZEGdBnAVxFsRZEGdBnAVxFsRZEGdBnAVxFsNZDWc1nBVxVsRZEWdFnBVxVsRZEWdFnBVxVsRZEWc1nM1wNsPZEGdDnA1xNsTZEGdDnA1xNsTZEGdDnA1xNsPZDWc3nB1xdsTZEWdHnB1xdsTZEWdHnB1xdsTZEWc3nMNwDsM5EOdAnANxDsQ5EOdAnANxDsQ5EOdAnANxDsM5Dec0nBNxTsQ5EedEnBNxTsQ5EedEnBNxTsQ5ESdqC9z5hC59Qrc+oWuf0L1P6OIndPMTuvoJ3f2ELn9Ctz//K7jZpPW8f7g+/fP3ok36uv9yenlFbcssc9ax5FpKXC4/AJJn0Lo=',
	},
	box2: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV2t9qU0EQB+B32esIOyf7N68ivag2yoE2KSYVpeTdjbXihQr9bk92Dgn7MfyGyXP6cP+0f/yyHs5p95zWj8fDKe3eP6fT+vlwe//z2eH2YZ926dPx6XB3e16Ph3TZpPVwt/+WdnG52aTzer//VfR4PK0vJ65l10/HJn1Pu3fb6/l/veSv8xPPR9aC0IJFC7ZaULSgakHTgq4FetGhN/36jZa3nh94fuL53/IWlbeovEXlLSpvUXmLyltU3qLyFpX35oJFb/r1JwRSDaQaSjWUaijVUKqhVEOphlINpRpKNZRqKNUwqtmkZoOa0WlGphmVZkSa0WhGohmFZgSa0WdGnhl1ZsOJbRS7qDZR7aHaQrWDagPV/qntU7unNk/tndo6sXNiHMU0qmFUs6hGUU2iGkQ1h2oM1RSqIVQzqEZQTKBbw4lDus7oOqLrhK4Dus7nOp7rdK7Duc7mOppvESdO8sVwFsNZEGdBnAVxFsRZEGdBnAVxFsRZEGdBnAVxFsNZDWc1nBVxVsRZEWdFnBVxVsRZEWdFnBVxVsRZEWc1nM1wNsPZEGdDnA1xNsTZEGdDnA1xNsTZEGdDnA1xNsPZDWc3nB1xdsTZEWdHnB1xdsTZEWdHnB1xdsTZEWc3nMNwDsM5EOdAnANxDsQ5EOdAnANxDsQ5EOdAnANxDsM5Dec0nBNxTsQ5EedEnBNxTsQ5EedEnBNxTsQ5ESdqC9z5hC59Qrc+oWuf0L1P6OIndPMTuvoJ3f2ELn9Ctz//K7jZpPW8f7g+/fP3ok36uv9yenlFbcssc9ax5FpKXC4/AJJn0Lo=',
	},
	box3: {
		expands: 'box1',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV2t9qU0EQB+B32esIOyf7N68ivag2yoE2KSYVpeTdjbXihQr9bk92Dgn7MfyGyXP6cP+0f/yyHs5p95zWj8fDKe3eP6fT+vlwe//z2eH2YZ926dPx6XB3e16Ph3TZpPVwt/+WdnG52aTzer//VfR4PK0vJ65l10/HJn1Pu3fb6/l/veSv8xPPR9aC0IJFC7ZaULSgakHTgq4FetGhN/36jZa3nh94fuL53/IWlbeovEXlLSpvUXmLyltU3qLyFpX35oJFb/r1JwRSDaQaSjWUaijVUKqhVEOphlINpRpKNZRqKNUwqtmkZoOa0WlGphmVZkSa0WhGohmFZgSa0WdGnhl1ZsOJbRS7qDZR7aHaQrWDagPV/qntU7unNk/tndo6sXNiHMU0qmFUs6hGUU2iGkQ1h2oM1RSqIVQzqEZQTKBbw4lDus7oOqLrhK4Dus7nOp7rdK7Duc7mOppvESdO8sVwFsNZEGdBnAVxFsRZEGdBnAVxFsRZEGdBnAVxFsNZDWc1nBVxVsRZEWdFnBVxVsRZEWdFnBVxVsRZEWc1nM1wNsPZEGdDnA1xNsTZEGdDnA1xNsTZEGdDnA1xNsPZDWc3nB1xdsTZEWdHnB1xdsTZEWdHnB1xdsTZEWc3nMNwDsM5EOdAnANxDsQ5EOdAnANxDsQ5EOdAnANxDsM5Dec0nBNxTsQ5EedEnBNxTsQ5EedEnBNxTsQ5ESdqC9z5hC59Qrc+oWuf0L1P6OIndPMTuvoJ3f2ELn9Ctz//K7jZpPW8f7g+/fP3ok36uv9yenlFbcssc9ax5FpKXC4/AJJn0Lo=',
	},
	box4: {
		expands: 'box2',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV2t9qU0EQB+B32esIOyf7N68ivag2yoE2KSYVpeTdjbXihQr9bk92Dgn7MfyGyXP6cP+0f/yyHs5p95zWj8fDKe3eP6fT+vlwe//z2eH2YZ926dPx6XB3e16Ph3TZpPVwt/+WdnG52aTzer//VfR4PK0vJ65l10/HJn1Pu3fb6/l/veSv8xPPR9aC0IJFC7ZaULSgakHTgq4FetGhN/36jZa3nh94fuL53/IWlbeovEXlLSpvUXmLyltU3qLyFpX35oJFb/r1JwRSDaQaSjWUaijVUKqhVEOphlINpRpKNZRqKNUwqtmkZoOa0WlGphmVZkSa0WhGohmFZgSa0WdGnhl1ZsOJbRS7qDZR7aHaQrWDagPV/qntU7unNk/tndo6sXNiHMU0qmFUs6hGUU2iGkQ1h2oM1RSqIVQzqEZQTKBbw4lDus7oOqLrhK4Dus7nOp7rdK7Duc7mOppvESdO8sVwFsNZEGdBnAVxFsRZEGdBnAVxFsRZEGdBnAVxFsNZDWc1nBVxVsRZEWdFnBVxVsRZEWdFnBVxVsRZEWc1nM1wNsPZEGdDnA1xNsTZEGdDnA1xNsTZEGdDnA1xNsPZDWc3nB1xdsTZEWdHnB1xdsTZEWdHnB1xdsTZEWc3nMNwDsM5EOdAnANxDsQ5EOdAnANxDsQ5EOdAnANxDsM5Dec0nBNxTsQ5EedEnBNxTsQ5EedEnBNxTsQ5ESdqC9z5hC59Qrc+oWuf0L1P6OIndPMTuvoJ3f2ELn9Ctz//K7jZpPW8f7g+/fP3ok36uv9yenlFbcssc9ax5FpKXC4/AJJn0Lo=',
	},
	uModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV1stOwzAQheF3mXUWzfiSSV4FsQjUIEupUzUpAkV5d5IWiQUg8W/tY2v0+Sy8yNNwTedLLrN0i+TnsUzSPSwy5dfSD/ta6U9JOnkZr+XYz3ksslaSyzG9S1evj5XMeUj3Q+dxyrfEdmzfPVTysYeqXy/5ma9hXlle4TwK51E4z5ePQh+FPgp9FPoo9FHo46CPgz4O+jjo46CPgz4e+njo46GPhz4e+njoE6BPgD4B+gToE6BPgD4R+kToE6FPhD4R+kTo00CfBvr8P+9g3sN8gPkI8w3MG8y3LK/wfRW+r9L3vc9jsG8G+2awbwb7ZrBvBvtmsG8G+2awbwb7ZrBvBvv2R377qec5nbbV7y9/JW/pMt1uCFFb37bB9BC8r9f1E1+s620=',
	},
	iModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqV1csKwjAQheF3mXWFJia95FXERdUogZqKbUUpfXfjBVyoi3+b5AwfwwyZZNOO/nQOcRA3Sdh2sRe3mqQPh9i0j7PYHL042Xdj3DVD6KLMmYS481dxal5nMoTWv0Knrg/PFymWbo3O5CZusUyBX1W+A0saMDTwJmlK0pSkKUlRkqIkBUk5FOUQlEMP7RBtEO0PHSI6Q3SE6J7RNaNbZqDHQI+BHgs9Fnos9BTQU0BPAT0l9JTQU0JPBT0V9Px5n760MPhjOv38jZlc/Ll/VrCFrk1d20rn1hg1z3c1VVmG',
	},
	tModule: {
		expands: 'hub',
		tech: { count: 1, time: 10, ingredients: [['automation-science-pack', 1]] },
		blueprint:
			'0eNqVltFugyAUQP/lPttEbgGVX2n2YFe2kFhsqi5tjP9e1i3Zw7aH84qcg8KJYZXjsMTLNeVZwirpdcyThMMqU3rP/fA5lvtzlCBv45JP/ZzGLFslKZ/iTYLZXiqZ0xC/oMs4peeMgpWnrq7kLmG3L8Bflt+AoYBSYE8BSwFHAU+BhgItBToIeHrSHp/09wpKW1LaktKWlLaktCWlLSltSWlLSltS2pLSlvC2GrqtBq5QwwVq6KcfQN+fdkdPgP4j6U/YQr+Ffgf9Dvo99Hvob6C/gf4W+v+ZX+4YaY7nMvpzWankI16np8F57WzXuVZrZ63ZtgcVxtkp',
	},
};
