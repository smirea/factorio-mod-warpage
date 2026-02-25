// data updates, no game global

import { disableRecipe, hideItem } from './lib/data-utils';

import '@/modules/ship/data.ts';
import '@/modules/thermite/data.ts';

disableRecipe('gun-turret');
hideItem('gun-turret');

const jellynut = data.raw.capsule.jellynut;
const jellynutAttackParameters = (jellynut?.capsule_action as any)?.attack_parameters;
if (jellynutAttackParameters?.cooldown != null) {
	jellynutAttackParameters.cooldown /= 2;
}
