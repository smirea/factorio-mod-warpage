import { modNs } from '@/lib/constants';

const guiNs = (name: string) => `warpage_${name}`;

export const names = {
	force: 'player',
	surface: 'nauvis',

	hubLandingPad: modNs('hub-landing-pad'),
	hubAccumulator: modNs('hub-accumulator'),
	hubPowerPole: modNs('hub-power-pole'),
	hubFluidPipe: modNs('hub-fluid-pipe'),
	destroyedHub: modNs('destroyed-hub-container'),

	uiRoot: guiNs('hub_ui'),
	uiPowerLabel: guiNs('hub_ui_power_label'),
	uiPowerBar: guiNs('hub_ui_power_bar'),
	uiFluidTable: guiNs('hub_ui_fluid_table'),
	uiFluidLeftIcon: '[virtual-signal=signal-left]',
	uiFluidRightIcon: '[virtual-signal=signal-right]',
	uiFluidEmptyIcon: '[virtual-signal=signal-deny]',
} as const;
