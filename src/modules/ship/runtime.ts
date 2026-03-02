import type { LuaEntity, MapPosition } from 'factorio:runtime';
import { ShipModuleId } from './constants';
import { GeneratedShipRotation, shipGeneratedGeometry } from './generated';

export type ShipRotation =
	| defines.direction.north
	| defines.direction.east
	| defines.direction.south
	| defines.direction.west;
export type ShipConnectorOrientation = 'horizontal' | 'vertical';
export type ShipConnectorSide = 'north' | 'east' | 'south' | 'west';
export type ShipTilePosition = {
	x: number;
	y: number;
};
export type ShipConnectorPlacement = {
	topLeft: ShipTilePosition;
	orientation: ShipConnectorOrientation;
	tiles: [ShipTilePosition, ShipTilePosition];
	sideHint?: ShipConnectorSide;
};
export type ShipConnectorPlacementWithSide = ShipConnectorPlacement & {
	side: ShipConnectorSide;
	outward: ShipTilePosition;
};

type RotatedModuleGeometry = {
	bounds: {
		minX: number;
		maxX: number;
		minY: number;
		maxY: number;
	};
	connectorCandidateSides: Record<string, ShipConnectorSide[] | undefined>;
	defaultConnectors: ShipConnectorPlacementWithSide[];
	tiles: ShipTilePosition[];
	tileKeys: Record<string, true | undefined>;
};

const geometryCache: Partial<Record<ShipModuleId, Record<ShipRotation, RotatedModuleGeometry>>> = {};
const shipRotations: ShipRotation[] = [
	defines.direction.north,
	defines.direction.east,
	defines.direction.south,
	defines.direction.west,
];

export function normalizeRotation(direction: defines.direction): ShipRotation {
	if (direction === defines.direction.east) return defines.direction.east;
	if (direction === defines.direction.south) return defines.direction.south;
	if (direction === defines.direction.west) return defines.direction.west;
	return defines.direction.north;
}

export function tileKey(x: number, y: number) {
	return `${x},${y}`;
}

export function connectorToTiles(topLeft: ShipTilePosition, orientation: ShipConnectorOrientation) {
	if (orientation === 'horizontal')
		return [
			{ x: topLeft.x, y: topLeft.y },
			{ x: topLeft.x + 1, y: topLeft.y },
		] as [ShipTilePosition, ShipTilePosition];

	return [
		{ x: topLeft.x, y: topLeft.y },
		{ x: topLeft.x, y: topLeft.y + 1 },
	] as [ShipTilePosition, ShipTilePosition];
}

export function connectorDirection(orientation: ShipConnectorOrientation) {
	return orientation === 'horizontal' ? defines.direction.north : defines.direction.east;
}

export function connectorEntityPosition(topLeft: ShipTilePosition, orientation: ShipConnectorOrientation) {
	return orientation === 'horizontal'
		? { x: topLeft.x + 1, y: topLeft.y + 0.5 }
		: { x: topLeft.x + 0.5, y: topLeft.y + 1 };
}

export function readConnectorPlacement(entity: LuaEntity): ShipConnectorPlacement {
	const orientation: ShipConnectorOrientation =
		entity.direction === defines.direction.east || entity.direction === defines.direction.west
			? 'vertical'
			: 'horizontal';
	const topLeft =
		orientation === 'horizontal'
			? {
					x: math.floor(entity.position.x - 1 + 0.001),
					y: math.floor(entity.position.y - 0.5 + 0.001),
				}
			: {
					x: math.floor(entity.position.x - 0.5 + 0.001),
					y: math.floor(entity.position.y - 1 + 0.001),
				};

	return {
		topLeft,
		orientation,
		tiles: connectorToTiles(topLeft, orientation),
		sideHint: directionToSide(entity.direction),
	};
}

export function connectorPlacementInsideModule(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	placement: ShipConnectorPlacement,
) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	for (const tile of placement.tiles) {
		const relative = {
			x: tile.x - center.x,
			y: tile.y - center.y,
		};
		if (!geometry.tileKeys[tileKey(relative.x, relative.y)]) return false;
	}

	return true;
}

export function connectorPlacementEdgeSide(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	placement: ShipConnectorPlacement,
	preferredSide?: ShipConnectorSide,
) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	const relativeTopLeft = {
		x: placement.topLeft.x - center.x,
		y: placement.topLeft.y - center.y,
	};
	const key = connectorCandidateKey(relativeTopLeft.x, relativeTopLeft.y, placement.orientation);
	const sides = geometry.connectorCandidateSides[key];
	if (!sides || sides.length === 0) return;

	if (preferredSide && sides.includes(preferredSide)) return preferredSide;
	if (placement.sideHint && sides.includes(placement.sideHint)) return placement.sideHint;
	return sides[0];
}

export function moduleWorldTiles(moduleId: ShipModuleId, center: MapPosition, rotation: ShipRotation) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	return geometry.tiles.map(tile => ({
		x: center.x + tile.x,
		y: center.y + tile.y,
	}));
}

export function moduleWorldTileKeys(moduleId: ShipModuleId, center: MapPosition, rotation: ShipRotation) {
	const keys: Record<string, true | undefined> = {};
	for (const tile of moduleWorldTiles(moduleId, center, rotation)) keys[tileKey(tile.x, tile.y)] = true;
	return keys;
}

export function moduleWorldBounds(moduleId: ShipModuleId, center: MapPosition, rotation: ShipRotation) {
	const bounds = getRotatedModuleGeometry(moduleId, rotation).bounds;
	return {
		minX: center.x + bounds.minX,
		maxX: center.x + bounds.maxX,
		minY: center.y + bounds.minY,
		maxY: center.y + bounds.maxY,
	};
}

export function moduleDefaultConnectorPlacements(moduleId: ShipModuleId, center: MapPosition, rotation: ShipRotation) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	return geometry.defaultConnectors.map(connector => ({
		orientation: connector.orientation,
		side: connector.side,
		outward: connector.outward,
		topLeft: {
			x: center.x + connector.topLeft.x,
			y: center.y + connector.topLeft.y,
		},
		tiles: connector.tiles.map(tile => ({
			x: center.x + tile.x,
			y: center.y + tile.y,
		})) as [ShipTilePosition, ShipTilePosition],
	}));
}

export function outwardVector(side: ShipConnectorSide): ShipTilePosition {
	switch (side) {
		case 'north':
			return { x: 0, y: -1 };
		case 'east':
			return { x: 1, y: 0 };
		case 'south':
			return { x: 0, y: 1 };
		case 'west':
			return { x: -1, y: 0 };
	}
}

export function oppositeSide(side: ShipConnectorSide): ShipConnectorSide {
	switch (side) {
		case 'north':
			return 'south';
		case 'east':
			return 'west';
		case 'south':
			return 'north';
		case 'west':
			return 'east';
	}
}

export function translateConnectorPlacement(
	placement: ShipConnectorPlacement,
	vector: ShipTilePosition,
	distance: number,
): ShipConnectorPlacement {
	const x = vector.x * distance;
	const y = vector.y * distance;
	const topLeft = {
		x: placement.topLeft.x + x,
		y: placement.topLeft.y + y,
	};
	return {
		topLeft,
		orientation: placement.orientation,
		tiles: connectorToTiles(topLeft, placement.orientation),
	};
}

export function rotateRelativeTile(tile: ShipTilePosition, rotation: ShipRotation) {
	switch (normalizeRotation(rotation)) {
		case defines.direction.east:
			return { x: -tile.y, y: tile.x };
		case defines.direction.south:
			return { x: -tile.x, y: -tile.y };
		case defines.direction.west:
			return { x: tile.y, y: -tile.x };
		default:
			return { x: tile.x, y: tile.y };
	}
}

export function rotateSide(side: ShipConnectorSide, rotation: ShipRotation): ShipConnectorSide {
	let final = side;
	for (let i = 0; i < rotationSteps(rotation); i += 1)
		switch (final) {
			case 'north':
				final = 'east';
				break;
			case 'east':
				final = 'south';
				break;
			case 'south':
				final = 'west';
				break;
			case 'west':
				final = 'north';
				break;
		}

	return final;
}

export function rotationDelta(from: ShipRotation, to: ShipRotation): ShipRotation {
	const delta = (rotationSteps(to) - rotationSteps(from) + 4) % 4;
	switch (delta) {
		case 1:
			return defines.direction.east;
		case 2:
			return defines.direction.south;
		case 3:
			return defines.direction.west;
		default:
			return defines.direction.north;
	}
}

export function rotateConnectorPlacementRelative(
	placement: ShipConnectorPlacement,
	rotation: ShipRotation,
): ShipConnectorPlacement {
	const tileA = rotateRelativeTile(placement.tiles[0], rotation);
	const tileB = rotateRelativeTile(placement.tiles[1], rotation);
	const orientation: ShipConnectorOrientation = tileA.y === tileB.y ? 'horizontal' : 'vertical';
	const topLeft = {
		x: tileA.x < tileB.x ? tileA.x : tileB.x,
		y: tileA.y < tileB.y ? tileA.y : tileB.y,
	};
	return {
		topLeft,
		orientation,
		tiles: connectorToTiles(topLeft, orientation),
	};
}

export function rotateConnectorTopLeftAroundCenter(
	topLeft: ShipTilePosition,
	orientation: ShipConnectorOrientation,
	rotation: ShipRotation,
) {
	return rotateConnectorPlacementRelative(
		{
			topLeft,
			orientation,
			tiles: connectorToTiles(topLeft, orientation),
		},
		rotation,
	);
}

function getRotatedModuleGeometry(moduleId: ShipModuleId, rotation: ShipRotation): RotatedModuleGeometry {
	const normalizedRotation = normalizeRotation(rotation);
	const moduleCache = (geometryCache[moduleId] ||= {} as Record<ShipRotation, RotatedModuleGeometry>);
	const cached = moduleCache[normalizedRotation];
	if (cached !== undefined) return cached;

	const generated = shipGeneratedGeometry[moduleId][rotationName(normalizedRotation)];
	const tileKeys: Record<string, true | undefined> = {};
	const tiles = generated.tiles.map(([x, y]) => {
		const tile = { x, y };
		tileKeys[tileKey(x, y)] = true;
		return tile;
	});
	const connectorCandidateSides: Record<string, ShipConnectorSide[] | undefined> = {};
	for (const connector of generated.connectorCandidates) {
		const key = connectorCandidateKey(connector.topLeft[0], connector.topLeft[1], connector.orientation);
		const existing = connectorCandidateSides[key];
		if (existing) {
			if (!existing.includes(connector.side)) existing.push(connector.side);
			continue;
		}
		connectorCandidateSides[key] = [connector.side];
	}

	const toPlacement = (input: {
		topLeft: [number, number];
		orientation: ShipConnectorOrientation;
		side: ShipConnectorSide;
	}): ShipConnectorPlacementWithSide => {
		const topLeft = {
			x: input.topLeft[0],
			y: input.topLeft[1],
		};
		return {
			topLeft,
			orientation: input.orientation,
			side: input.side,
			outward: outwardVector(input.side),
			tiles: connectorToTiles(topLeft, input.orientation),
		};
	};

	const defaultConnectors: ShipConnectorPlacementWithSide[] = [];
	for (const connector of generated.defaultConnectors) defaultConnectors.push(toPlacement(connector));

	const geometry: RotatedModuleGeometry = {
		tiles,
		tileKeys,
		bounds: generated.bounds,
		connectorCandidateSides,
		defaultConnectors,
	};
	moduleCache[normalizedRotation] = geometry;
	return geometry;
}

function rotationName(rotation: ShipRotation): GeneratedShipRotation {
	switch (normalizeRotation(rotation)) {
		case defines.direction.east:
			return 'east';
		case defines.direction.south:
			return 'south';
		case defines.direction.west:
			return 'west';
		default:
			return 'north';
	}
}

function directionToSide(direction: defines.direction): ShipConnectorSide | undefined {
	switch (normalizeRotation(direction)) {
		case defines.direction.east:
			return 'east';
		case defines.direction.south:
			return 'south';
		case defines.direction.west:
			return 'west';
		case defines.direction.north:
			return 'north';
	}
}

function connectorCandidateKey(x: number, y: number, orientation: ShipConnectorOrientation) {
	return `${x},${y},${orientation}`;
}

function rotationSteps(rotation: ShipRotation) {
	switch (normalizeRotation(rotation)) {
		case defines.direction.east:
			return 1;
		case defines.direction.south:
			return 2;
		case defines.direction.west:
			return 3;
		default:
			return 0;
	}
}

export { shipRotations };
