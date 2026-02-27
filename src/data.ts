// data updates, no game global

import { disableRecipe, hideItem } from './lib/data-utils';

import '@/modules/ship/data.ts';
import '@/modules/thermite/data.ts';

disableRecipe('gun-turret');
hideItem('gun-turret');

const jellynut = data.raw.capsule.jellynut;
if (!jellynut) throw new Error("Missing capsule 'jellynut'.");

const jellynutAttackParameters = (jellynut.capsule_action as any)?.attack_parameters;
if (!jellynutAttackParameters || jellynutAttackParameters.cooldown == null)
	throw new Error("Capsule 'jellynut' is missing attack_parameters.cooldown.");

jellynutAttackParameters.cooldown /= 2;
