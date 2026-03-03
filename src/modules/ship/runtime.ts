import type { LuaEntity, MapPosition } from 'factorio:runtime';
import { ShipConnectorSize, ShipModuleId } from './constants';
import { shipModuleData } from './generated';

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
	size: ShipConnectorSize;
	topLeft: ShipTilePosition;
	orientation: ShipConnectorOrientation;
	tiles: ShipTilePosition[];
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
	connectorCandidateSidesBySize: Record<ShipConnectorSize, Record<string, ShipConnectorSide[] | undefined>>;
	connectorCandidatesBySize: Record<ShipConnectorSize, ShipConnectorPlacementWithSide[]>;
	defaultConnectors: ShipConnectorPlacementWithSide[];
	tiles: ShipTilePosition[];
	tileKeys: Record<string, true | undefined>;
};
type ConnectorCandidate = {
	orientation: ShipConnectorOrientation;
	side: ShipConnectorSide;
	topLeft: [number, number];
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

export function connectorToTiles(
	topLeft: ShipTilePosition,
	orientation: ShipConnectorOrientation,
	size: ShipConnectorSize,
) {
	const tiles: ShipTilePosition[] = [];
	for (let index = 0; index < size; index += 1)
		tiles.push(
			orientation === 'horizontal' ? { x: topLeft.x + index, y: topLeft.y } : { x: topLeft.x, y: topLeft.y + index },
		);
	return tiles;
}

export function connectorDirection(orientation: ShipConnectorOrientation) {
	return orientation === 'horizontal' ? defines.direction.north : defines.direction.east;
}

export function connectorEntityPosition(
	topLeft: ShipTilePosition,
	orientation: ShipConnectorOrientation,
	size: ShipConnectorSize,
) {
	return orientation === 'horizontal'
		? { x: topLeft.x + size / 2, y: topLeft.y + 0.5 }
		: { x: topLeft.x + 0.5, y: topLeft.y + size / 2 };
}

export function readConnectorPlacement(entity: LuaEntity, size: ShipConnectorSize): ShipConnectorPlacement {
	const orientation: ShipConnectorOrientation =
		entity.direction === defines.direction.east || entity.direction === defines.direction.west
			? 'vertical'
			: 'horizontal';
	const topLeft =
		orientation === 'horizontal'
			? {
					x: math.floor(entity.position.x - size / 2 + 0.001),
					y: math.floor(entity.position.y - 0.5 + 0.001),
				}
			: {
					x: math.floor(entity.position.x - 0.5 + 0.001),
					y: math.floor(entity.position.y - size / 2 + 0.001),
				};

	return {
		size,
		topLeft,
		orientation,
		tiles: connectorToTiles(topLeft, orientation, size),
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
	size: ShipConnectorSize,
	preferredSide?: ShipConnectorSide,
) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	const relativeTopLeft = {
		x: placement.topLeft.x - center.x,
		y: placement.topLeft.y - center.y,
	};
	const key = connectorCandidateKey(relativeTopLeft.x, relativeTopLeft.y, placement.orientation);
	const sides = geometry.connectorCandidateSidesBySize[size][key];
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
		size: connector.size,
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
		})),
	}));
}

export function moduleConnectorCandidates(
	moduleId: ShipModuleId,
	center: MapPosition,
	rotation: ShipRotation,
	size: ShipConnectorSize,
) {
	const geometry = getRotatedModuleGeometry(moduleId, rotation);
	return geometry.connectorCandidatesBySize[size].map(connector => ({
		size: connector.size,
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
		})),
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
		size: placement.size,
		topLeft,
		orientation: placement.orientation,
		tiles: connectorToTiles(topLeft, placement.orientation, placement.size),
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
	const rotatedTiles = placement.tiles.map(tile => rotateRelativeTile(tile, rotation));
	const tileA = rotatedTiles[0]!;
	const tileB = rotatedTiles[1]!;
	const orientation: ShipConnectorOrientation = tileA.y === tileB.y ? 'horizontal' : 'vertical';
	const topLeft = {
		x: Math.min(...rotatedTiles.map(tile => tile.x)),
		y: Math.min(...rotatedTiles.map(tile => tile.y)),
	};
	return {
		size: placement.size,
		topLeft,
		orientation,
		tiles: connectorToTiles(topLeft, orientation, placement.size),
	};
}

export function rotateConnectorTopLeftAroundCenter(
	topLeft: ShipTilePosition,
	orientation: ShipConnectorOrientation,
	rotation: ShipRotation,
	size: ShipConnectorSize,
) {
	return rotateConnectorPlacementRelative(
		{
			size,
			topLeft,
			orientation,
			tiles: connectorToTiles(topLeft, orientation, size),
		},
		rotation,
	);
}

function getRotatedModuleGeometry(moduleId: ShipModuleId, rotation: ShipRotation): RotatedModuleGeometry {
	const normalizedRotation = normalizeRotation(rotation);
	const moduleCache = (geometryCache[moduleId] ||= {} as Record<ShipRotation, RotatedModuleGeometry>);
	const cached = moduleCache[normalizedRotation];
	if (cached !== undefined) return cached;

	const tiles = shipModuleData[moduleId].tiles.map(([x, y]) => rotateRelativeTile({ x, y }, normalizedRotation));
	tiles.sort((a, b) => (a.y === b.y ? a.x - b.x : a.y - b.y));
	const tileKeys = toTileSet(tiles);
	const bounds = computeBounds(tiles);

	const toPlacement = (input: {
		topLeft: [number, number];
		orientation: ShipConnectorOrientation;
		side: ShipConnectorSide;
		size: ShipConnectorSize;
	}): ShipConnectorPlacementWithSide => {
		const topLeft = {
			x: input.topLeft[0],
			y: input.topLeft[1],
		};
		return {
			size: input.size,
			topLeft,
			orientation: input.orientation,
			side: input.side,
			outward: outwardVector(input.side),
			tiles: connectorToTiles(topLeft, input.orientation, input.size),
		};
	};

	const connectorCandidateSidesBySize = {} as RotatedModuleGeometry['connectorCandidateSidesBySize'];
	const connectorCandidatesBySize = {} as RotatedModuleGeometry['connectorCandidatesBySize'];
	for (const size of [2, 3, 4] as const) {
		const generatedCandidates = computeConnectorCandidates(tiles, tileKeys, bounds, size);
		const sideMap: Record<string, ShipConnectorSide[] | undefined> = {};
		const placements: ShipConnectorPlacementWithSide[] = [];
		for (const connector of generatedCandidates) {
			const candidateKey = connectorCandidateKey(connector.topLeft[0], connector.topLeft[1], connector.orientation);
			const existing = sideMap[candidateKey];
			if (existing) {
				if (!existing.includes(connector.side)) existing.push(connector.side);
			} else sideMap[candidateKey] = [connector.side];
			placements.push(
				toPlacement({
					topLeft: connector.topLeft,
					orientation: connector.orientation,
					side: connector.side,
					size,
				}),
			);
		}
		connectorCandidateSidesBySize[size] = sideMap;
		connectorCandidatesBySize[size] = placements;
	}

	const defaultConnectors: ShipConnectorPlacementWithSide[] = [];

	const geometry: RotatedModuleGeometry = {
		tiles,
		tileKeys,
		bounds,
		connectorCandidateSidesBySize,
		connectorCandidatesBySize,
		defaultConnectors,
	};
	moduleCache[normalizedRotation] = geometry;
	return geometry;
}

function computeConnectorCandidates(
	tiles: ShipTilePosition[],
	tileSet: Record<string, true | undefined>,
	bounds: RotatedModuleGeometry['bounds'],
	size: 2 | 3 | 4,
) {
	const outside = computeOutsideReachable(tileSet, bounds);
	const candidates: ConnectorCandidate[] = [];
	for (const tile of tiles) {
		const horizontalTopLeft: [number, number] = [tile.x, tile.y];
		if (connectorTilesInside(horizontalTopLeft, 'horizontal', size, tileSet)) {
			const northOpen = connectorSideOutside(horizontalTopLeft, 'horizontal', size, outside, 'north');
			const southOpen = connectorSideOutside(horizontalTopLeft, 'horizontal', size, outside, 'south');
			if (northOpen) candidates.push({ topLeft: horizontalTopLeft, orientation: 'horizontal', side: 'north' });
			if (southOpen) candidates.push({ topLeft: horizontalTopLeft, orientation: 'horizontal', side: 'south' });
		}

		const verticalTopLeft: [number, number] = [tile.x, tile.y];
		if (connectorTilesInside(verticalTopLeft, 'vertical', size, tileSet)) {
			const westOpen = connectorSideOutside(verticalTopLeft, 'vertical', size, outside, 'west');
			const eastOpen = connectorSideOutside(verticalTopLeft, 'vertical', size, outside, 'east');
			if (eastOpen) candidates.push({ topLeft: verticalTopLeft, orientation: 'vertical', side: 'east' });
			if (westOpen) candidates.push({ topLeft: verticalTopLeft, orientation: 'vertical', side: 'west' });
		}
	}
	return sortConnectorCandidates(dedupeConnectorCandidates(candidates));
}

function connectorTilesInside(
	topLeft: [number, number],
	orientation: ShipConnectorOrientation,
	size: 2 | 3 | 4,
	tileSet: Record<string, true | undefined>,
) {
	if (orientation === 'horizontal') {
		for (let offset = 0; offset < size; offset += 1)
			if (!tileSet[tileKey(topLeft[0] + offset, topLeft[1])]) return false;
		return true;
	}

	for (let offset = 0; offset < size; offset += 1) if (!tileSet[tileKey(topLeft[0], topLeft[1] + offset)]) return false;
	return true;
}

function connectorSideOutside(
	topLeft: [number, number],
	orientation: ShipConnectorOrientation,
	size: 2 | 3 | 4,
	outside: Record<string, true | undefined>,
	side: ShipConnectorSide,
) {
	if (orientation === 'horizontal') {
		const y = side === 'north' ? topLeft[1] - 1 : topLeft[1] + 1;
		for (let offset = 0; offset < size; offset += 1) if (!outside[tileKey(topLeft[0] + offset, y)]) return false;
		return true;
	}

	const x = side === 'west' ? topLeft[0] - 1 : topLeft[0] + 1;
	for (let offset = 0; offset < size; offset += 1) if (!outside[tileKey(x, topLeft[1] + offset)]) return false;
	return true;
}

function computeOutsideReachable(tileSet: Record<string, true | undefined>, bounds: RotatedModuleGeometry['bounds']) {
	const minX = bounds.minX - 1;
	const maxX = bounds.maxX + 1;
	const minY = bounds.minY - 1;
	const maxY = bounds.maxY + 1;
	const outside: Record<string, true | undefined> = {};
	const queue: ShipTilePosition[] = [];

	const enqueue = (x: number, y: number) => {
		if (x < minX || x > maxX || y < minY || y > maxY) return;
		const key = tileKey(x, y);
		if (tileSet[key]) return;
		if (outside[key]) return;
		outside[key] = true;
		queue.push({ x, y });
	};

	for (let x = minX; x <= maxX; x += 1) {
		enqueue(x, minY);
		enqueue(x, maxY);
	}
	for (let y = minY; y <= maxY; y += 1) {
		enqueue(minX, y);
		enqueue(maxX, y);
	}

	for (let index = 0; index < queue.length; index += 1) {
		const point = queue[index]!;
		enqueue(point.x + 1, point.y);
		enqueue(point.x - 1, point.y);
		enqueue(point.x, point.y + 1);
		enqueue(point.x, point.y - 1);
	}
	return outside;
}

function computeBounds(tiles: ShipTilePosition[]): RotatedModuleGeometry['bounds'] {
	let minX = tiles[0]!.x;
	let maxX = tiles[0]!.x;
	let minY = tiles[0]!.y;
	let maxY = tiles[0]!.y;
	for (const tile of tiles) {
		if (tile.x < minX) minX = tile.x;
		if (tile.x > maxX) maxX = tile.x;
		if (tile.y < minY) minY = tile.y;
		if (tile.y > maxY) maxY = tile.y;
	}
	return { minX, maxX, minY, maxY };
}

function toTileSet(tiles: ShipTilePosition[]) {
	const tileSet: Record<string, true | undefined> = {};
	for (const tile of tiles) tileSet[tileKey(tile.x, tile.y)] = true;
	return tileSet;
}

function dedupeConnectorCandidates(connectors: ConnectorCandidate[]) {
	const seen = new Set<string>();
	const unique: ConnectorCandidate[] = [];
	for (const connector of connectors) {
		const key = `${connector.topLeft[0]},${connector.topLeft[1]},${connector.orientation},${connector.side}`;
		if (seen.has(key)) continue;
		seen.add(key);
		unique.push(connector);
	}
	return unique;
}

function sortConnectorCandidates(connectors: ConnectorCandidate[]) {
	const sideOrder: Record<ShipConnectorSide, number> = {
		north: 0,
		east: 1,
		south: 2,
		west: 3,
	};
	const orientationOrder: Record<ShipConnectorOrientation, number> = {
		horizontal: 0,
		vertical: 1,
	};
	return [...connectors].sort((a, b) => {
		if (a.topLeft[1] !== b.topLeft[1]) return a.topLeft[1] - b.topLeft[1];
		if (a.topLeft[0] !== b.topLeft[0]) return a.topLeft[0] - b.topLeft[0];
		if (a.orientation !== b.orientation) return orientationOrder[a.orientation] - orientationOrder[b.orientation];
		return sideOrder[a.side] - sideOrder[b.side];
	});
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
