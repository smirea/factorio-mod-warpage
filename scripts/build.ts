#!/usr/bin/env bun

import { execSync, type ExecSyncOptionsWithBufferEncoding } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { deflateSync, inflateSync } from 'node:zlib';

type ModuleId = string;
type Rotation = 'north' | 'east' | 'south' | 'west';
type Orientation = 'horizontal' | 'vertical';
type Side = 'north' | 'east' | 'south' | 'west';
type Point = {
	x: number;
	y: number;
};
type ConnectorDefinition = {
	orientation: Orientation;
	topLeft: [number, number];
};
type ConnectorWithSide = {
	orientation: Orientation;
	side: Side;
	topLeft: [number, number];
};
type RotationGeometry = {
	bounds: {
		maxX: number;
		maxY: number;
		minX: number;
		minY: number;
	};
	connectorCandidates: ConnectorWithSide[];
	defaultConnectors: ConnectorWithSide[];
	tiles: Array<[number, number]>;
};
type ModuleGeometry = Record<Rotation, RotationGeometry>;
type ModuleBuildData = {
	defaultConnectors: ConnectorDefinition[];
	geometry: ModuleGeometry;
	iconPath: string;
	placementPreviewPaths: Record<Rotation, string>;
	moduleId: ModuleId;
};

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.resolve(scriptDir, '..');
const srcDir = path.join(rootDir, 'src');
const mustImportNames = ['control.ts', 'data-final-fixes.ts', 'data-updates.ts', 'data.ts'];
const toCopy: string[] = ['locale', 'info.json', 'thumbnail.png'];
const generatedFilePath = path.join(srcDir, 'modules', 'ship', 'generated.ts');
const iconDir = path.join(srcDir, 'modules', 'ship', 'graphics');
const legacyGeneratedIconDir = path.join(srcDir, 'modules', 'ship', 'graphics', 'generated');

function main() {
	generateShipModuleArtifacts();

	const allFiles = cmd(`find ${srcDir} -type f`, { stdio: undefined })
		.split('\n')
		.filter(file => file.length > 0);
	const errors: string[] = [];
	for (const file of allFiles) {
		if (!file.endsWith('.ts')) {
			if (!file.endsWith('.md')) toCopy.push(file);
			continue;
		}

		const fileName = path.basename(file);
		if (!mustImportNames.includes(fileName)) continue;
		const moduleName = path.basename(path.dirname(file));
		if (moduleName === 'src') continue;
		const canonicalPath = path.join(srcDir, fileName);
		const importString = `import '@/modules/${moduleName}/${fileName}';`;
		if (!fs.existsSync(canonicalPath)) {
			errors.push(`src/${fileName} does not exist, create it and add: \`${importString}\``);
			continue;
		}
		const canonical = fs.readFileSync(canonicalPath, 'utf8');
		if (!canonical.includes(importString)) errors.push(`src/${fileName} is missing \`${importString}\``);
	}

	if (errors.length > 0) {
		console.error('Errors:');
		for (const error of errors) console.error(error);
		process.exit(1);
	}

	cmd('rm -rf compiled');
	cmd('./node_modules/.bin/tstl');

	for (const fullFilePath of toCopy) {
		const source = fullFilePath.replace(rootDir + path.sep, '');
		const parts = source.split(path.sep);
		if (parts[0] === 'src') parts.shift();
		const dest = path.join(rootDir, 'compiled', ...parts);
		console.log('copy:', source);
		fs.mkdirSync(path.dirname(dest), { recursive: true });
		if (fs.statSync(fullFilePath).isDirectory()) cmd(`cp -r '${fullFilePath}' '${dest}'`);
		else fs.copyFileSync(fullFilePath, dest);
	}
}

function generateShipModuleArtifacts() {
	const constantsPath = path.join(srcDir, 'modules', 'ship', 'constants.ts');
	const constantsSource = fs.readFileSync(constantsPath, 'utf8');
	const moduleIds = readShipModuleIds(constantsSource);
	const moduleDefinitions = readModuleDefinitions(constantsSource, moduleIds);
	const moduleBuildData: ModuleBuildData[] = [];
	const keepIconNames: Record<string, true | undefined> = {};

	fs.mkdirSync(iconDir, { recursive: true });
	for (const moduleId of moduleIds) {
		const definition = moduleDefinitions[moduleId];
		if (!definition) throw new Error(`Missing module definition for '${moduleId}'.`);

		const normalizedTiles = normalizeTiles(decodeBlueprintTiles(definition.blueprint));
		const iconFileName = `module-${moduleId}.png`;
		const iconPath = `__warpage__/modules/ship/graphics/${iconFileName}`;
		keepIconNames[iconFileName] = true;
		writePng(path.join(iconDir, iconFileName), 64, 64, rasterizeShape(normalizedTiles));

		const geometry = buildModuleGeometry(normalizedTiles, definition.connectors);
		const placementPreviewPaths = {} as Record<Rotation, string>;
		for (const rotation of ['north', 'east', 'south', 'west'] as const) {
			const placementFileName = `module-${moduleId}-placement-${rotation}.png`;
			const placementPath = `__warpage__/modules/ship/graphics/${placementFileName}`;
			keepIconNames[placementFileName] = true;
			placementPreviewPaths[rotation] = placementPath;
			const tiles = geometry[rotation].tiles.map(([x, y]) => ({ x, y }));
			const candidateTileKeys = connectorCandidateTileKeys(geometry[rotation].connectorCandidates);
			writePng(path.join(iconDir, placementFileName), 64, 64, rasterizeShape(tiles, candidateTileKeys));
		}
		moduleBuildData.push({
			moduleId,
			iconPath,
			placementPreviewPaths,
			geometry,
			defaultConnectors: definition.connectors,
		});
	}

	for (const file of fs.readdirSync(iconDir)) {
		if (!file.startsWith('module-')) continue;
		if (!file.endsWith('.png')) continue;
		if (keepIconNames[file]) continue;
		fs.unlinkSync(path.join(iconDir, file));
	}
	if (fs.existsSync(legacyGeneratedIconDir)) {
		for (const file of fs.readdirSync(legacyGeneratedIconDir)) {
			if (!file.startsWith('module-')) continue;
			if (!file.endsWith('.png')) continue;
			fs.unlinkSync(path.join(legacyGeneratedIconDir, file));
		}
		if (fs.readdirSync(legacyGeneratedIconDir).length === 0) fs.rmdirSync(legacyGeneratedIconDir);
	}

	fs.writeFileSync(generatedFilePath, renderGeneratedTs(moduleBuildData), 'utf8');
}

function readShipModuleIds(constantsSource: string) {
	const match = constantsSource.match(/export const shipModuleIds = \[([^\]]+)\] as const;/);
	if (!match) throw new Error('Unable to parse shipModuleIds.');
	return match[1]
		.split(',')
		.map(raw => raw.trim().replaceAll("'", ''))
		.filter(value => value.length > 0);
}

function readModuleDefinitions(constantsSource: string, moduleIds: string[]) {
	const definitions: Record<ModuleId, { blueprint: string; connectors: ConnectorDefinition[] } | undefined> = {};
	const moduleBlockRegex = /^\t([a-zA-Z0-9_]+):\s*{([\s\S]*?)\n\t},?/gm;
	for (const match of constantsSource.matchAll(moduleBlockRegex)) {
		const moduleId = match[1];
		if (!moduleIds.includes(moduleId)) continue;
		const block = match[2];
		const blueprintMatch = block.match(/\n\t\tblueprint:\s*'([^']+)'/);
		if (!blueprintMatch) throw new Error(`Missing blueprint for '${moduleId}'.`);
		definitions[moduleId] = {
			blueprint: blueprintMatch[1],
			connectors: readModuleConnectors(block),
		};
	}
	return definitions;
}

function readModuleConnectors(block: string) {
	const connectorsMatch = block.match(/\n\t\tconnectors:\s*\[([\s\S]*?)\n\t\t],?/m);
	if (!connectorsMatch) return [];
	const connectorsBlock = connectorsMatch[1];
	const connectors: ConnectorDefinition[] = [];
	const connectorRegex =
		/{\s*orientation:\s*'(horizontal|vertical)'\s*,\s*position:\s*{\s*x:\s*(-?\d+(?:\.\d+)?)\s*,\s*y:\s*(-?\d+(?:\.\d+)?)\s*}\s*}/gm;
	for (const match of connectorsBlock.matchAll(connectorRegex))
		connectors.push({
			orientation: match[1] as Orientation,
			topLeft: [Number(match[2]), Number(match[3])],
		});

	return connectors;
}

function decodeBlueprintTiles(blueprint: string) {
	const encoded = blueprint.startsWith('0') ? blueprint.slice(1) : blueprint;
	const decoded = inflateSync(Buffer.from(encoded, 'base64')).toString('utf8');
	const parsed = JSON.parse(decoded) as {
		blueprint?: {
			tiles?: Array<{
				position: {
					x: number;
					y: number;
				};
			}>;
		};
	};
	const blueprintTiles = parsed.blueprint?.tiles;
	if (!blueprintTiles || blueprintTiles.length === 0)
		throw new Error('Ship module blueprint does not contain any tiles.');
	return blueprintTiles.map(tile => ({
		x: Number(tile.position.x),
		y: Number(tile.position.y),
	}));
}

function normalizeTiles(tiles: Point[]) {
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

	const center = {
		x: Math.ceil((minX + maxX) / 2),
		y: Math.ceil((minY + maxY) / 2),
	};
	const unique: Record<string, true | undefined> = {};
	const normalized: Point[] = [];
	for (const tile of tiles) {
		const normalizedTile = {
			x: tile.x - center.x,
			y: tile.y - center.y,
		};
		const key = `${normalizedTile.x},${normalizedTile.y}`;
		if (unique[key]) continue;
		unique[key] = true;
		normalized.push(normalizedTile);
	}
	normalized.sort((a, b) => (a.y - b.y === 0 ? a.x - b.x : a.y - b.y));
	return normalized;
}

function buildModuleGeometry(baseTiles: Point[], baseDefaultConnectors: ConnectorDefinition[]): ModuleGeometry {
	const byRotation = {} as ModuleGeometry;
	const rotationStepsByName: Record<Rotation, number> = {
		north: 0,
		east: 1,
		south: 2,
		west: 3,
	};
	const northTiles = normalizeTiles(baseTiles.map(tile => rotateRelativeTile(tile, 0)));
	const northTileSet = toTileSet(northTiles);
	const northBounds = computeBounds(northTiles);
	const northConnectorCandidates = computeConnectorCandidates(northTiles, northTileSet, northBounds);

	for (const rotation of ['north', 'east', 'south', 'west'] as const) {
		const steps = rotationStepsByName[rotation];
		const rotatedTiles = normalizeTiles(baseTiles.map(tile => rotateRelativeTile(tile, steps)));
		const tileSet = toTileSet(rotatedTiles);
		const bounds = computeBounds(rotatedTiles);
		const connectorCandidates = computeConnectorCandidates(rotatedTiles, tileSet, bounds);
		const defaultConnectors = rotateDefaultConnectors(baseDefaultConnectors, northConnectorCandidates, steps);

		byRotation[rotation] = {
			bounds,
			tiles: rotatedTiles.map(tile => [tile.x, tile.y]),
			connectorCandidates,
			defaultConnectors,
		};
	}

	return byRotation;
}

function rotateDefaultConnectors(
	baseDefaultConnectors: ConnectorDefinition[],
	northConnectorCandidates: ConnectorWithSide[],
	steps: number,
) {
	if (baseDefaultConnectors.length === 0) return [];

	const northSidesByPlacement: Record<string, Side[] | undefined> = {};
	for (const candidate of northConnectorCandidates) {
		const key = connectorPlacementKey(candidate.topLeft, candidate.orientation);
		const existing = northSidesByPlacement[key];
		if (existing) {
			if (!existing.includes(candidate.side)) existing.push(candidate.side);
			continue;
		}
		northSidesByPlacement[key] = [candidate.side];
	}

	const defaultConnectors: ConnectorWithSide[] = [];
	for (const connector of baseDefaultConnectors) {
		const sides = northSidesByPlacement[connectorPlacementKey(connector.topLeft, connector.orientation)];
		if (!sides || sides.length === 0)
			throw new Error(
				`Default connector ${connector.orientation}@${connector.topLeft[0]},${connector.topLeft[1]} is not on outside-reachable perimeter.`,
			);
		const side = pickDefaultSide(sides);
		const rotatedPlacement = rotateConnectorPlacement(connector.topLeft, connector.orientation, steps);
		defaultConnectors.push({
			topLeft: rotatedPlacement.topLeft,
			orientation: rotatedPlacement.orientation,
			side: rotateSide(side, steps),
		});
	}
	return sortConnectors(defaultConnectors);
}

function pickDefaultSide(sides: Side[]) {
	for (const side of ['north', 'east', 'south', 'west'] as const) if (sides.includes(side)) return side;
	return sides[0]!;
}

function rotateConnectorPlacement(topLeft: [number, number], orientation: Orientation, steps: number) {
	const tiles = connectorToTiles(topLeft, orientation).map(tile => rotateRelativeTile(tile, steps));
	const orientationAfterRotation: Orientation = tiles[0]!.y === tiles[1]!.y ? 'horizontal' : 'vertical';
	const minX = Math.min(tiles[0]!.x, tiles[1]!.x);
	const minY = Math.min(tiles[0]!.y, tiles[1]!.y);
	return {
		topLeft: [minX, minY] as [number, number],
		orientation: orientationAfterRotation,
	};
}

function rotateRelativeTile(tile: Point, steps: number) {
	const normalizedSteps = ((steps % 4) + 4) % 4;
	if (normalizedSteps === 1) return { x: -tile.y, y: tile.x };
	if (normalizedSteps === 2) return { x: -tile.x, y: -tile.y };
	if (normalizedSteps === 3) return { x: tile.y, y: -tile.x };
	return { x: tile.x, y: tile.y };
}

function rotateSide(side: Side, steps: number): Side {
	let rotated = side;
	const normalizedSteps = ((steps % 4) + 4) % 4;
	for (let index = 0; index < normalizedSteps; index += 1)
		switch (rotated) {
			case 'north':
				rotated = 'east';
				break;
			case 'east':
				rotated = 'south';
				break;
			case 'south':
				rotated = 'west';
				break;
			case 'west':
				rotated = 'north';
				break;
		}

	return rotated;
}

function computeConnectorCandidates(
	tiles: Point[],
	tileSet: Record<string, true | undefined>,
	bounds: RotationGeometry['bounds'],
) {
	const outside = computeOutsideReachable(tileSet, bounds);
	const candidates: ConnectorWithSide[] = [];
	for (const tile of tiles) {
		const horizontalTopLeft: [number, number] = [tile.x, tile.y];
		if (tileSet[tileKey(tile.x + 1, tile.y)]) {
			const northOpen =
				outside[tileKey(tile.x, tile.y - 1)] === true && outside[tileKey(tile.x + 1, tile.y - 1)] === true;
			const southOpen =
				outside[tileKey(tile.x, tile.y + 1)] === true && outside[tileKey(tile.x + 1, tile.y + 1)] === true;
			if (northOpen) candidates.push({ topLeft: horizontalTopLeft, orientation: 'horizontal', side: 'north' });
			if (southOpen) candidates.push({ topLeft: horizontalTopLeft, orientation: 'horizontal', side: 'south' });
		}

		const verticalTopLeft: [number, number] = [tile.x, tile.y];
		if (tileSet[tileKey(tile.x, tile.y + 1)]) {
			const westOpen =
				outside[tileKey(tile.x - 1, tile.y)] === true && outside[tileKey(tile.x - 1, tile.y + 1)] === true;
			const eastOpen =
				outside[tileKey(tile.x + 1, tile.y)] === true && outside[tileKey(tile.x + 1, tile.y + 1)] === true;
			if (eastOpen) candidates.push({ topLeft: verticalTopLeft, orientation: 'vertical', side: 'east' });
			if (westOpen) candidates.push({ topLeft: verticalTopLeft, orientation: 'vertical', side: 'west' });
		}
	}
	return sortConnectors(dedupeConnectors(candidates));
}

function dedupeConnectors(connectors: ConnectorWithSide[]) {
	const seen: Record<string, true | undefined> = {};
	const unique: ConnectorWithSide[] = [];
	for (const connector of connectors) {
		const key = `${connector.topLeft[0]},${connector.topLeft[1]},${connector.orientation},${connector.side}`;
		if (seen[key]) continue;
		seen[key] = true;
		unique.push(connector);
	}
	return unique;
}

function sortConnectors(connectors: ConnectorWithSide[]) {
	const sideOrder: Record<Side, number> = {
		north: 0,
		east: 1,
		south: 2,
		west: 3,
	};
	const orientationOrder: Record<Orientation, number> = {
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

function computeOutsideReachable(tileSet: Record<string, true | undefined>, bounds: RotationGeometry['bounds']) {
	const minX = bounds.minX - 1;
	const maxX = bounds.maxX + 1;
	const minY = bounds.minY - 1;
	const maxY = bounds.maxY + 1;
	const outside: Record<string, true | undefined> = {};
	const queue: Point[] = [];

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

function toTileSet(tiles: Point[]) {
	const tileSet: Record<string, true | undefined> = {};
	for (const tile of tiles) tileSet[tileKey(tile.x, tile.y)] = true;
	return tileSet;
}

function computeBounds(tiles: Point[]): RotationGeometry['bounds'] {
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

function tileKey(x: number, y: number) {
	return `${x},${y}`;
}

function connectorPlacementKey(topLeft: [number, number], orientation: Orientation) {
	return `${topLeft[0]},${topLeft[1]},${orientation}`;
}

function connectorToTiles(topLeft: [number, number], orientation: Orientation) {
	if (orientation === 'horizontal')
		return [
			{ x: topLeft[0], y: topLeft[1] },
			{ x: topLeft[0] + 1, y: topLeft[1] },
		] as [Point, Point];

	return [
		{ x: topLeft[0], y: topLeft[1] },
		{ x: topLeft[0], y: topLeft[1] + 1 },
	] as [Point, Point];
}

function connectorCandidateTileKeys(candidates: ConnectorWithSide[]) {
	const tileKeysByCandidate: Record<string, true | undefined> = {};
	for (const candidate of candidates)
		for (const tile of connectorToTiles(candidate.topLeft, candidate.orientation))
			tileKeysByCandidate[tileKey(tile.x, tile.y)] = true;

	return tileKeysByCandidate;
}

function renderGeneratedTs(modules: ModuleBuildData[]) {
	const icons: Record<string, string> = {};
	const placementPreviews: Record<string, Record<Rotation, string>> = {};
	const geometry: Record<string, Record<Rotation, RotationGeometry>> = {};
	for (const module of modules) {
		icons[module.moduleId] = module.iconPath;
		placementPreviews[module.moduleId] = module.placementPreviewPaths;
		geometry[module.moduleId] = module.geometry;
	}

	return [
		'/* oxlint-disable */',
		'// oxfmt-ignore-file',
		'// Generated via scripts/build.ts',
		'// Do not edit manually.',
		'',
		"import { ShipModuleId } from './constants';",
		'',
		"export type GeneratedShipRotation = 'north' | 'east' | 'south' | 'west';",
		"export type GeneratedShipOrientation = 'horizontal' | 'vertical';",
		"export type GeneratedShipSide = 'north' | 'east' | 'south' | 'west';",
		'export type GeneratedShipConnector = {',
		'\ttopLeft: [number, number];',
		'\torientation: GeneratedShipOrientation;',
		'\tside: GeneratedShipSide;',
		'};',
		'export type GeneratedShipModuleRotation = {',
		'\tbounds: {',
		'\t\tmaxX: number;',
		'\t\tmaxY: number;',
		'\t\tminX: number;',
		'\t\tminY: number;',
		'\t};',
		'\tconnectorCandidates: GeneratedShipConnector[];',
		'\tdefaultConnectors: GeneratedShipConnector[];',
		'\ttiles: Array<[number, number]>;',
		'};',
		'',
		`export const shipGeneratedIcons: Record<ShipModuleId, string> = ${JSON.stringify(icons)};`,
		`export const shipGeneratedPlacementPreviews: Record<ShipModuleId, Record<GeneratedShipRotation, string>> = ${JSON.stringify(placementPreviews)};`,
		`export const shipGeneratedGeometry: Record<ShipModuleId, Record<GeneratedShipRotation, GeneratedShipModuleRotation>> = ${JSON.stringify(geometry)};`,
		'',
	].join('\n');
}

function rasterizeShape(tiles: Point[], highlightedTileKeys?: Record<string, true | undefined>) {
	const width = 64;
	const height = 64;
	const pixels = Buffer.alloc(width * height * 4, 0);
	if (tiles.length === 0) return pixels;

	const bounds = computeBounds(tiles);
	const tileSpanX = bounds.maxX - bounds.minX + 1;
	const tileSpanY = bounds.maxY - bounds.minY + 1;
	const maxSpan = Math.max(tileSpanX, tileSpanY);
	const tileSize = Math.max(4, Math.floor(52 / maxSpan));
	const shapeWidth = tileSpanX * tileSize;
	const shapeHeight = tileSpanY * tileSize;
	const offsetX = Math.floor((width - shapeWidth) / 2);
	const offsetY = Math.floor((height - shapeHeight) / 2);
	const fill = [50, 190, 220, 255] as const;
	const border = [12, 70, 95, 255] as const;
	const tileSet = toTileSet(tiles);

	for (const tile of tiles) {
		const x0 = offsetX + (tile.x - bounds.minX) * tileSize;
		const y0 = offsetY + (tile.y - bounds.minY) * tileSize;
		fillRect(pixels, width, height, x0, y0, tileSize, tileSize, fill);
		if (highlightedTileKeys?.[tileKey(tile.x, tile.y)])
			fillRect(
				pixels,
				width,
				height,
				x0 + 1,
				y0 + 1,
				Math.max(1, tileSize - 2),
				Math.max(1, tileSize - 2),
				[242, 166, 66, 255],
			);

		if (!tileSet[tileKey(tile.x - 1, tile.y)]) fillRect(pixels, width, height, x0, y0, 1, tileSize, border);
		if (!tileSet[tileKey(tile.x + 1, tile.y)])
			fillRect(pixels, width, height, x0 + tileSize - 1, y0, 1, tileSize, border);
		if (!tileSet[tileKey(tile.x, tile.y - 1)]) fillRect(pixels, width, height, x0, y0, tileSize, 1, border);
		if (!tileSet[tileKey(tile.x, tile.y + 1)])
			fillRect(pixels, width, height, x0, y0 + tileSize - 1, tileSize, 1, border);
	}

	return pixels;
}

function fillRect(
	pixels: Buffer,
	width: number,
	height: number,
	x: number,
	y: number,
	w: number,
	h: number,
	color: readonly [number, number, number, number],
) {
	for (let dy = 0; dy < h; dy += 1) {
		const py = y + dy;
		if (py < 0 || py >= height) continue;
		for (let dx = 0; dx < w; dx += 1) {
			const px = x + dx;
			if (px < 0 || px >= width) continue;
			const offset = (py * width + px) * 4;
			pixels[offset] = color[0];
			pixels[offset + 1] = color[1];
			pixels[offset + 2] = color[2];
			pixels[offset + 3] = color[3];
		}
	}
}

function writePng(filePath: string, width: number, height: number, rgbaPixels: Buffer) {
	const rowBytes = width * 4;
	const raw = Buffer.alloc((rowBytes + 1) * height, 0);
	for (let y = 0; y < height; y += 1) {
		const src = y * rowBytes;
		const dst = y * (rowBytes + 1) + 1;
		rgbaPixels.copy(raw, dst, src, src + rowBytes);
	}

	const ihdr = Buffer.alloc(13);
	ihdr.writeUInt32BE(width, 0);
	ihdr.writeUInt32BE(height, 4);
	ihdr[8] = 8;
	ihdr[9] = 6;
	ihdr[10] = 0;
	ihdr[11] = 0;
	ihdr[12] = 0;

	const output = Buffer.concat([
		Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]),
		pngChunk('IHDR', ihdr),
		pngChunk('IDAT', deflateSync(raw)),
		pngChunk('IEND', Buffer.alloc(0)),
	]);
	fs.writeFileSync(filePath, output);
}

function pngChunk(type: string, data: Buffer) {
	const typeBuffer = Buffer.from(type, 'ascii');
	const lengthBuffer = Buffer.alloc(4);
	lengthBuffer.writeUInt32BE(data.length, 0);
	const crcBuffer = Buffer.alloc(4);
	crcBuffer.writeUInt32BE(crc32(Buffer.concat([typeBuffer, data])), 0);
	return Buffer.concat([lengthBuffer, typeBuffer, data, crcBuffer]);
}

const crcTable = (() => {
	const table = new Uint32Array(256);
	for (let n = 0; n < 256; n += 1) {
		let c = n;
		for (let k = 0; k < 8; k += 1) c = (c & 1) === 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
		table[n] = c >>> 0;
	}
	return table;
})();

function crc32(buffer: Buffer) {
	let crc = 0xffffffff;
	for (const byte of buffer) crc = crcTable[(crc ^ byte) & 0xff]! ^ (crc >>> 8);
	return (crc ^ 0xffffffff) >>> 0;
}

function cmd(str: string, args?: ExecSyncOptionsWithBufferEncoding) {
	return execSync(str, { cwd: rootDir, stdio: 'inherit', ...args })
		?.toString()
		.trim();
}

main();
