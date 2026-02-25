// data updates, no game global

import { disableRecipe, hideItem } from './lib/data-utils';

import '@/modules/ship/data.ts';
import '@/modules/thermite/data.ts';

disableRecipe('gun-turret');
hideItem('gun-turret');
