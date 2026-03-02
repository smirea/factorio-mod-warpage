import { ShipModuleId } from '@/modules/ship/constants';
import { TechnologyUnit } from 'factorio:prototype';
import { MapPosition } from 'factorio:runtime';

declare global {
	interface ModStorage {
		surface: string;
		hubRepaired: boolean;
		shipModules: Record<
			ShipModuleId,
			{
				center: MapPosition;
				connectorUnitNumbers: number[];
				placed: boolean;
				rotation: defines.direction.north | defines.direction.east | defines.direction.south | defines.direction.west;
				unlocked: boolean;
			}
		>;
		shipConnectors: Record<
			string,
			{
				moduleId: ShipModuleId;
				orientation: 'vertical' | 'horizontal';
				side: 'north' | 'east' | 'south' | 'west';
				topLeft: MapPosition;
			}
		>;
		shipBridges: Record<
			string,
			{
				connectorUnitNumber: number;
				targetConnectorUnitNumber?: number;
				tiles: MapPosition[];
			}
		>;
		shipPlacementByPlayer: Record<
			number,
			| {
					mode: 'move' | 'place';
					moduleId: ShipModuleId;
					renderIds: number[];
			  }
			| undefined
		>;
		startupSuppliesSeeded: boolean;
		startConfiguredPlayerIndices: Record<number, true | undefined>;
	}

	const storage: ModStorage;

	/** Build time macro evals to `path.join(__dirname, ...parts)` since there is no __dirname natively */
	const DIR_PATH_JOIN: (...parts: string[]) => string;

	/** Build time macro evals to [`${section}.${key}`, ...args] after checking that the locale exists */
	const LOCALE: (
		section:
			| 'entity-description'
			| 'entity-name'
			| 'item-description'
			| 'item-name'
			| 'mod-setting-description'
			| 'mod-setting-name'
			| 'recipe-name'
			| 'technology-description'
			| 'technology-effect'
			| 'technology-name',
		key: string,
		...args: (string | number)[]
	) => [string, ...(string | number)[]];
}

export type SciencePack =
	| 'automation-science-pack'
	| 'logistic-science-pack'
	| 'military-science-pack'
	| 'chemical-science-pack'
	| 'production-science-pack'
	| 'utility-science-pack'
	| 'space-science-pack'
	| 'metallurgic-science-pack'
	| 'agricultural-science-pack'
	| 'electromagnetic-science-pack'
	| 'cryogenic-science-pack'
	| 'promethium-science-pack';

export type TypedTechnologyUnit = Omit<TechnologyUnit, 'ingredients'> & {
	ingredients: ReadonlyArray<[SciencePack, number]>;
};

declare module 'factorio:prototype' {
	interface PrototypeBase {
		subgroup?: string &
			(
				| 'agriculture-explosions'
				| 'agriculture-processes'
				| 'agriculture-products'
				| 'agriculture-remnants'
				| 'agriculture'
				| 'ammo-category'
				| 'ammo'
				| 'aquilo-processes'
				| 'aquilo-tiles'
				| 'armor'
				| 'arrows-misc'
				| 'arrows'
				| 'artificial-tiles'
				| 'barrel'
				| 'belt-explosions'
				| 'belt-remnants'
				| 'belt'
				| 'bullets'
				| 'campaign-explosions'
				| 'capsule-explosions'
				| 'capsule'
				| 'circuit-network-explosions'
				| 'circuit-network-remnants'
				| 'circuit-network'
				| 'cliffs'
				| 'corpses'
				| 'creatures'
				| 'decorative-explosions'
				| 'defensive-structure-explosions'
				| 'defensive-structure-remnants'
				| 'defensive-structure'
				| 'empty-barrel'
				| 'enemies'
				| 'enemy-death-explosions'
				| 'energy-explosions'
				| 'energy-pipe-distribution-explosions'
				| 'energy-pipe-distribution-remnants'
				| 'energy-pipe-distribution'
				| 'energy-remnants'
				| 'energy'
				| 'environmental-protection-explosions'
				| 'environmental-protection-remnants'
				| 'environmental-protection'
				| 'equipment'
				| 'explosions'
				| 'extraction-machine-explosions'
				| 'extraction-machine-remnants'
				| 'extraction-machine'
				| 'fill-barrel'
				| 'fluid-explosions'
				| 'fluid-recipes'
				| 'fluid'
				| 'fulgora-processes'
				| 'fulgora-tiles'
				| 'generic-remnants'
				| 'gleba-tiles'
				| 'gleba-water-tiles'
				| 'grass'
				| 'ground-explosions'
				| 'gun-explosions'
				| 'gun'
				| 'hit-effects'
				| 'inserter-explosions'
				| 'inserter-remnants'
				| 'inserter'
				| 'intermediate-product'
				| 'intermediate-recipe'
				| 'internal-process'
				| 'logistic-network-explosions'
				| 'logistic-network-remnants'
				| 'logistic-network'
				| 'military-equipment'
				| 'mineable-fluids'
				| 'module-explosions'
				| 'module'
				| 'nauvis-agriculture'
				| 'nauvis-tiles'
				| 'obstacles'
				| 'other'
				| 'parameters'
				| 'particles'
				| 'pictographs'
				| 'planet-connections'
				| 'planets'
				| 'production-machine-explosions'
				| 'production-machine-remnants'
				| 'production-machine'
				| 'qualities'
				| 'raw-material'
				| 'raw-resource'
				| 'remnants'
				| 'rock-explosions'
				| 'science-pack'
				| 'scorchmarks'
				| 'shapes'
				| 'smelting-machine-explosions'
				| 'smelting-machine-remnants'
				| 'smelting-machine'
				| 'space-crushing'
				| 'space-environment'
				| 'space-interactors'
				| 'space-material'
				| 'space-platform-explosions'
				| 'space-platform-remnants'
				| 'space-platform'
				| 'space-processing'
				| 'space-related'
				| 'space-rocket'
				| 'spawnables'
				| 'special-tiles'
				| 'storage-explosions'
				| 'storage-remnants'
				| 'storage'
				| 'terrain'
				| 'tool'
				| 'train-transport-explosions'
				| 'train-transport-remnants'
				| 'train-transport'
				| 'transport-explosions'
				| 'transport-remnants'
				| 'transport'
				| 'tree-explosions'
				| 'trees'
				| 'turret'
				| 'uranium-processing'
				| 'utility-equipment'
				| 'virtual-signal-color'
				| 'virtual-signal-letter'
				| 'virtual-signal-math'
				| 'virtual-signal-number'
				| 'virtual-signal-punctuation'
				| 'virtual-signal-special'
				| 'virtual-signal'
				| 'vulcanus-processes'
				| 'vulcanus-tiles'
				| 'wrecks'
			);
	}
}
