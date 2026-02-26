import { modNs, nsFactory } from '@/lib/constants';
import { TypedTechnologyUnit } from '@/types';

const ns = nsFactory(modNs('ship'));

export const names = {
	ns,
	connector: ns('connector'),
	destroyedHub: ns('destroyed-hub-container'),
	hubAccumulator: ns('hub-accumulator'),
	hubFluidPipe: ns('hub-fluid-pipe'),
	hubLandingPad: ns('hub-landing-pad'),
	hubPowerPole: ns('hub-power-pole'),
	tile: ns('tile'),
	tileCollisionLayer: ns('tile-collision-layer'),
} as const;

type ShipModuleName = 'hub' | 'box1' | 'box2' | 'box3' | 'box4';
type ShipModuleDefinition = {
	blueprint: string;
	expands?: ShipModuleName;
	tech: TypedTechnologyUnit;
	connectors?: Array<{
		orientation: 'horizontal' | 'vertical';
		position: { x: number; y: number };
	}>;
};

export const shipModules: Record<ShipModuleName, ShipModuleDefinition> = {
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
};
