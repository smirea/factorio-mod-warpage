import { modNs } from '@/lib/constants';

export const names = {
	destroyedHub: modNs('destroyed-hub-container'),
	hubAccumulator: modNs('hub-accumulator'),
	hubFluidPipe: modNs('hub-fluid-pipe'),
	hubLandingPad: modNs('hub-landing-pad'),
	hubPowerPole: modNs('hub-power-pole'),
	tile: modNs('tile'),
	tileCollisionLayer: modNs('tile-collision-layer'),
} as const;
