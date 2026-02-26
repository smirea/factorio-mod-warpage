import { shipModules } from '@/modules/ship/constants';
import { MapPosition } from 'factorio:prototype';

declare global {
	interface ModStorage {
		surface: string;
		hubRepaired: boolean;
		shipLayout: Partial<
			Record<
				keyof typeof shipModules,
				{
					connectors: Array<{
						/** relative to the center of the module */
						position: MapPosition;
						orientation: 'vertical' | 'horizontal';
						module?: keyof typeof shipModules;
						moduleConnector?: number;
					}>;
				}
			>
		>;
		startupSuppliesSeeded: boolean;
		startConfiguredPlayerIndices: Record<number, true | undefined>;
	}

	const storage: ModStorage;

	/** Build time macro evals to `path.join(__dirname, ...parts)` since there is no __dirname natively */
	const DIR_PATH_JOIN: (...parts: string[]) => string;

	/** Build time macro evals to [`${section}.${key}`, ...args] after checking that the locale exists */
	const LOCALE: (section: string, key: string, ...args: (string | number)[]) => [string, ...(string | number)[]];
}
