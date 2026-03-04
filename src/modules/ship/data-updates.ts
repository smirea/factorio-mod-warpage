import { names, shipConnectorSizes, shipModuleIds } from './constants';

function init() {
	applyShipTileBuildabilityRule();
}

const applyShipTileBuildabilityRule = () => {
	const requiredTiles = {
		layers: {
			[names.tileCollisionLayer]: true as const,
		},
	};
	const rawByType = data.raw as Record<string, Record<string, any> | undefined>;
	const placeableEntityNames = new Set<string>();
	const ignoredPlaceResults = new Set<string>();
	for (const moduleId of shipModuleIds) ignoredPlaceResults.add(names.modulePlacementEntity(moduleId));
	for (const connectorSize of shipConnectorSizes)
		ignoredPlaceResults.add(names.connectorPlacementEntity(connectorSize));

	for (const prototypesByName of Object.values(rawByType)) {
		if (!prototypesByName) continue;

		for (const prototype of Object.values(prototypesByName)) {
			if (typeof prototype?.place_result !== 'string') continue;
			if (ignoredPlaceResults.has(prototype.place_result)) continue;

			placeableEntityNames.add(prototype.place_result);
		}
	}

	for (const prototypesByName of Object.values(rawByType)) {
		if (!prototypesByName) continue;

		for (const prototype of Object.values(prototypesByName)) {
			if (!prototype?.name || !prototype.collision_box) continue;

			if (!placeableEntityNames.has(prototype.name)) continue;

			prototype.tile_buildability_rules = [
				...(prototype.tile_buildability_rules ?? []),
				{
					area: prototype.collision_box,
					required_tiles: requiredTiles,
				},
			];
		}
	}
};

init();
