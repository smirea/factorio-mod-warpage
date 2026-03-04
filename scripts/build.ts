#!/usr/bin/env bun

import { execSync, type ExecSyncOptionsWithBufferEncoding } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { deflateSync, inflateSync } from 'node:zlib';
import { shipModuleIds, shipModules } from '../src/modules/ship/constants';

type ModuleId = string;
type Rotation = 'north' | 'east' | 'south' | 'west';
type Orientation = 'horizontal' | 'vertical';
type Side = 'north' | 'east' | 'south' | 'west';
type Point = {
	x: number;
	y: number;
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
	connectorCandidatesBySize: Record<'2' | '3' | '4', ConnectorWithSide[]>;
	defaultConnectors: ConnectorWithSide[];
	tiles: Array<[number, number]>;
};
type ModuleGeometry = Record<Rotation, RotationGeometry>;
type ShipModuleData = {
	icon: string;
	width: number;
	height: number;
	previews: Record<Rotation, string>;
	/** minimum number of points used to make this shape to work in conjunction with `LuaSurface.clone_brush({ source_positions })` */
	shapePoints: Array<[number, number]>;
	/** all tiles that are on the outer edge of the module (used to see valid connector placement areas) */
	externalTiles: Array<[number, number]>;
	tiles: Array<[number, number]>;
};
type ModuleBuildData = {
	moduleId: ModuleId;
	moduleData: ShipModuleData;
};

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.resolve(scriptDir, '..');
const srcDir = path.join(rootDir, 'src');
const mustImportNames = ['control.ts', 'data-final-fixes.ts', 'data-updates.ts', 'data.ts'];
const toCopy: string[] = ['locale', 'info.json', 'thumbnail.png'];
const generatedFilePath = path.join(srcDir, 'modules', 'ship', 'generated.ts');
const iconDir = path.join(srcDir, 'modules', 'ship', 'graphics');

function main() {
	generateShipModuleArtifacts();

	const allFiles = cmd(`find ${srcDir} -type f`, { stdio: 'pipe' })
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
		const importString = `import '@/modules/${moduleName}/${path.basename(fileName)}';`;
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
	cmd('./node_modules/.bin/tstl -p tsconfig.tstl.json');

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
	const moduleBuildData: ModuleBuildData[] = [];
	const keepIconNames = new Set<string>();

	fs.mkdirSync(iconDir, { recursive: true });
	for (const moduleId of shipModuleIds) {
		const moduleBlueprint = shipModules[moduleId]?.blueprint;
		if (!moduleBlueprint) throw new Error(`Missing blueprint for '${moduleId}'.`);

		const normalizedTiles = normalizeTiles(decodeBlueprintTiles(moduleBlueprint));
		const iconFileName = `module-${moduleId}.png`;
		const iconPath = `__warpage__/modules/ship/graphics/${iconFileName}`;
		keepIconNames.add(iconFileName);
		writePng(path.join(iconDir, iconFileName), 64, 64, rasterizeShape(normalizedTiles));

		const previews = {} as Record<Rotation, string>;
		const geometry = buildModuleGeometry(normalizedTiles);
		for (const rotation of ['north', 'east', 'south', 'west'] as const) {
			const placementFileName = `module-${moduleId}-placement-${rotation}.png`;
			const placementPath = `__warpage__/modules/ship/graphics/${placementFileName}`;
			keepIconNames.add(placementFileName);
			previews[rotation] = placementPath;
			const tiles = geometry[rotation].tiles.map(([x, y]) => ({ x, y }));
			const candidateTileKeys = connectorCandidateTileKeys(geometry[rotation].connectorCandidatesBySize['2']);
			writePng(path.join(iconDir, placementFileName), 64, 64, rasterizeShape(tiles, candidateTileKeys));
		}

		const bounds = computeBounds(normalizedTiles);
		const normalizedTilePairs = normalizedTiles.map(tile => [tile.x, tile.y] as [number, number]);
		const externalTiles = computeExternalTiles(normalizedTiles);
		const minimizedShapePoints = minimizeExternalTiles(externalTiles).map(tile => [tile.x, tile.y] as [number, number]);
		const externalTilePairs = externalTiles.map(tile => [tile.x, tile.y] as [number, number]);
		const moduleData: ShipModuleData = {
			icon: iconPath,
			width: bounds.maxX - bounds.minX + 1,
			height: bounds.maxY - bounds.minY + 1,
			previews,
			shapePoints: minimizedShapePoints,
			externalTiles: externalTilePairs,
			tiles: normalizedTilePairs,
		};
		moduleBuildData.push({
			moduleId,
			moduleData,
		});
	}

	for (const file of fs.readdirSync(iconDir)) {
		if (!file.startsWith('module-')) continue;
		if (!file.endsWith('.png')) continue;
		if (keepIconNames.has(file)) continue;
		fs.unlinkSync(path.join(iconDir, file));
	}

	fs.writeFileSync(generatedFilePath, renderGeneratedTs(moduleBuildData), 'utf8');
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
	const unique = new Set<string>();
	const normalized: Point[] = [];
	for (const tile of tiles) {
		const normalizedTile = {
			x: tile.x - center.x,
			y: tile.y - center.y,
		};
		const key = `${normalizedTile.x},${normalizedTile.y}`;
		if (unique.has(key)) continue;
		unique.add(key);
		normalized.push(normalizedTile);
	}
	normalized.sort((a, b) => (a.y - b.y === 0 ? a.x - b.x : a.y - b.y));
	return normalized;
}

function buildModuleGeometry(baseTiles: Point[]): ModuleGeometry {
	const byRotation = {} as ModuleGeometry;
	const rotationStepsByName: Record<Rotation, number> = {
		north: 0,
		east: 1,
		south: 2,
		west: 3,
	};

	for (const rotation of ['north', 'east', 'south', 'west'] as const) {
		const steps = rotationStepsByName[rotation];
		const rotatedTiles = normalizeTiles(baseTiles.map(tile => rotateRelativeTile(tile, steps)));
		const tileSet = toTileSet(rotatedTiles);
		const bounds = computeBounds(rotatedTiles);
		const connectorCandidatesBySize = {
			'2': computeConnectorCandidates(rotatedTiles, tileSet, bounds, 2),
			'3': computeConnectorCandidates(rotatedTiles, tileSet, bounds, 3),
			'4': computeConnectorCandidates(rotatedTiles, tileSet, bounds, 4),
		} as const;

		byRotation[rotation] = {
			bounds,
			tiles: rotatedTiles.map(tile => [tile.x, tile.y]),
			connectorCandidatesBySize,
			defaultConnectors: [],
		};
	}

	return byRotation;
}

function computeExternalTiles(tiles: Point[]) {
	const tileSet = toTileSet(tiles);
	const bounds = computeBounds(tiles);
	const outside = computeOutsideReachable(tileSet, bounds);
	const externalTiles: Point[] = [];

	for (const tile of tiles) {
		if (
			outside[tileKey(tile.x, tile.y - 1)] ||
			outside[tileKey(tile.x + 1, tile.y)] ||
			outside[tileKey(tile.x, tile.y + 1)] ||
			outside[tileKey(tile.x - 1, tile.y)]
		)
			externalTiles.push(tile);
	}

	return externalTiles;
}

function minimizeExternalTiles(tiles: Point[]) {
	if (tiles.length <= 2) return tiles;

	const tileSet = toTileSet(tiles);
	const minimized = tiles.filter(tile => {
		const north = tileSet[tileKey(tile.x, tile.y - 1)] === true;
		const east = tileSet[tileKey(tile.x + 1, tile.y)] === true;
		const south = tileSet[tileKey(tile.x, tile.y + 1)] === true;
		const west = tileSet[tileKey(tile.x - 1, tile.y)] === true;
		const degree = (north ? 1 : 0) + (east ? 1 : 0) + (south ? 1 : 0) + (west ? 1 : 0);

		if (degree !== 2) return true;
		const isStraight = (north && south) || (east && west);
		return !isStraight;
	});

	if (minimized.length === 0) return [tiles[0]!];
	return minimized.sort((a, b) => (a.y - b.y === 0 ? a.x - b.x : a.y - b.y));
}

function rotateRelativeTile(tile: Point, steps: number) {
	const normalizedSteps = ((steps % 4) + 4) % 4;
	if (normalizedSteps === 1) return { x: -tile.y, y: tile.x };
	if (normalizedSteps === 2) return { x: -tile.x, y: -tile.y };
	if (normalizedSteps === 3) return { x: tile.y, y: -tile.x };
	return { x: tile.x, y: tile.y };
}

function computeConnectorCandidates(
	tiles: Point[],
	tileSet: Record<string, true | undefined>,
	bounds: RotationGeometry['bounds'],
	size: 2 | 3 | 4,
) {
	const outside = computeOutsideReachable(tileSet, bounds);
	const candidates: ConnectorWithSide[] = [];
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
	return sortConnectors(dedupeConnectors(candidates));
}

function connectorTilesInside(
	topLeft: [number, number],
	orientation: Orientation,
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
	orientation: Orientation,
	size: 2 | 3 | 4,
	outside: Record<string, true | undefined>,
	side: Side,
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

function dedupeConnectors(connectors: ConnectorWithSide[]) {
	const seen = new Set<string>();
	const unique: ConnectorWithSide[] = [];
	for (const connector of connectors) {
		const key = `${connector.topLeft[0]},${connector.topLeft[1]},${connector.orientation},${connector.side}`;
		if (seen.has(key)) continue;
		seen.add(key);
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
	const moduleData: Record<string, ShipModuleData> = {};
	for (const module of modules) moduleData[module.moduleId] = module.moduleData;

	return [
		'/* oxlint-disable */',
		'// oxfmt-ignore-file',
		'// Generated via scripts/build.ts',
		'// Do not edit manually.',
		'',
		"import { ShipModuleId } from './constants';",
		'',
		"export type GeneratedShipRotation = 'north' | 'east' | 'south' | 'west';",
		'export type ShipModuleData = {',
		'\t/** icon used for sprite buttons and technology icons */',
		'\ticon: string;',
		'\twidth: number;',
		'\theight: number;',
		'\t/** direction-specific module placement previews */',
		'\tpreviews: Record<GeneratedShipRotation, string>;',
		'\t/** minimum number of points used to make this shape to work in conjunction with `LuaSurface.clone_brush({ source_positions })` */',
		'\tshapePoints: Array<[number, number]>;',
		'\t/** all tiles that are on the outer edge of the module (used to see valid connector placement areas) */',
		'\texternalTiles: Array<[number, number]>;',
		'\ttiles: Array<[number, number]>;',
		'};',
		'',
		`export const shipModuleData: Record<ShipModuleId, ShipModuleData> = ${JSON.stringify(moduleData)};`,
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
