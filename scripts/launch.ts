#!/usr/bin/env bun

import { spawnSync } from 'node:child_process';
import {
	accessSync,
	constants as fsConstants,
	copyFileSync,
	existsSync,
	lstatSync,
	mkdirSync,
	readdirSync,
	readFileSync,
	readlinkSync,
	renameSync,
	statSync,
	symlinkSync,
	writeFileSync,
} from 'node:fs';
import { dirname, isAbsolute, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

type ModInfo = {
	name?: string;
	version?: string;
};

type ParsedArgs = {
	saveSelector: string;
	factorioArgs: string[];
};

const scriptDir = dirname(fileURLToPath(import.meta.url));
const repoRoot = resolve(scriptDir, '..');
const env = process.env;

const launchRoot = resolve(env.LAUNCH_ROOT ?? join(repoRoot, '.tmp/factorio-launch'));
const runModDir = join(launchRoot, 'mods');
const writeData = join(launchRoot, 'write-data');
const runSavesDir = join(writeData, 'saves');
const configFile = join(launchRoot, 'config.ini');
const canonicalSavesDir = join(repoRoot, 'saves');

const compiledDir = resolve(env.COMPILED_DIR ?? join(repoRoot, 'compiled'));
const defaultSaveName = env.SAVE_NAME ?? env.SAFE_SAVE_NAME ?? 'warpage-test';
const autosaveInterval = env.AUTOSAVE_INTERVAL ?? '0';
const headless = env.HEADLESS ?? '0';
const untilTick = env.UNTIL_TICK ?? '120';

const modInfo = readModInfo(join(repoRoot, 'info.json'));
const runModLink = join(runModDir, `${modInfo.name}_${modInfo.version}`);
const factorioBin = resolveFactorioBin(env.FACTORIO_BIN, env.HOME);

const parsedArgs = parseArgs(process.argv.slice(2), defaultSaveName);
const saveFile = resolveSaveFile(parsedArgs.saveSelector, runSavesDir, repoRoot);

console.log('Building mod');
runCommand(['bun', 'run', 'build'], { cwd: repoRoot });

assertDirectory(compiledDir, `Compiled directory not found: ${compiledDir}`);
assertFile(join(compiledDir, 'info.json'), `Compiled info.json not found: ${join(compiledDir, 'info.json')}`);

mkdirSync(runModDir, { recursive: true });
ensureDirectory(writeData);
ensureDirectory(canonicalSavesDir);

ensureSymlink(runModLink, compiledDir);
ensureSavesSymlink(runSavesDir, canonicalSavesDir);

writeConfig(configFile, writeData, autosaveInterval);
writeModList(join(runModDir, 'mod-list.json'), modInfo.name);

if (!existsSync(saveFile)) {
	console.log(`Save not found. Creating: ${saveFile}`);
	mkdirSync(dirname(saveFile), { recursive: true });
	runFactorio(factorioBin, [
		'--config',
		configFile,
		'--mod-directory',
		runModDir,
		'--disable-audio',
		'--verbose',
		'--create',
		saveFile,
	]);
}

const launchArgs = [
	'--config',
	configFile,
	'--mod-directory',
	runModDir,
	'--disable-audio',
	'--verbose',
	'--load-game',
	saveFile,
];

if (headless === '1') {
	launchArgs.push('--until-tick', untilTick);
}

launchArgs.push(...parsedArgs.factorioArgs);

console.log('Launching Factorio');
console.log(`save: ${saveFile}`);
console.log(`write-data: ${writeData}`);
console.log(`headless: ${headless}`);

runFactorio(factorioBin, launchArgs);

function parseArgs(args: string[], defaultName: string): ParsedArgs {
	const firstArg = args[0];
	if (!firstArg || firstArg.startsWith('--')) {
		return { saveSelector: defaultName, factorioArgs: args };
	}

	return {
		saveSelector: firstArg,
		factorioArgs: args.slice(1),
	};
}

function resolveSaveFile(saveSelector: string, savesDir: string, root: string): string {
	if (saveSelector.includes('/') || saveSelector.endsWith('.zip')) {
		return isAbsolute(saveSelector) ? saveSelector : resolve(root, saveSelector);
	}

	return join(savesDir, `${saveSelector}.zip`);
}

function resolveFactorioBin(explicitPath: string | undefined, home: string | undefined): string {
	if (explicitPath && explicitPath.trim().length > 0) {
		const candidate = explicitPath.trim();
		if (isExecutable(candidate)) {
			return candidate;
		}

		fail(`FACTORIO_BIN is not executable: ${candidate}`);
	}

	const candidates = [
		'/Applications/factorio.app/Contents/MacOS/factorio',
		home ? join(home, 'Applications/factorio.app/Contents/MacOS/factorio') : undefined,
		home ? join(home, '.factorio/bin/x64/factorio') : undefined,
		home ? join(home, 'Library/Application Support/factorio/bin/x64/factorio') : undefined,
		home
			? join(home, 'Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS/factorio')
			: undefined,
	].filter((value): value is string => value !== undefined);

	for (const candidate of candidates) {
		if (isExecutable(candidate)) {
			return candidate;
		}
	}

	fail('Factorio binary not found. Set FACTORIO_BIN explicitly or install Factorio in a standard location.');
}

function readModInfo(filePath: string): { name: string; version: string } {
	const parsed = JSON.parse(readFileSync(filePath, 'utf8')) as ModInfo;
	if (!parsed.name || !parsed.version) {
		fail(`Unable to read mod name/version from ${filePath}`);
	}

	return { name: parsed.name, version: parsed.version };
}

function writeConfig(filePath: string, dataPath: string, autosaveInterval: string): void {
	const config = [
		'[path]',
		'read-data=__PATH__system-read-data__',
		`write-data=${dataPath}`,
		'',
		'[other]',
		`autosave-interval=${autosaveInterval}`,
		'',
	].join('\n');
	writeFileSync(filePath, config, 'utf8');
}

function writeModList(filePath: string, modName: string): void {
	const modList = {
		mods: [
			{ name: 'base', enabled: true },
			{ name: 'elevated-rails', enabled: true },
			{ name: 'quality', enabled: true },
			{ name: 'space-age', enabled: true },
			{ name: 'simple-mod-reload', enabled: true },
			{ name: modName, enabled: true },
		],
	};
	writeFileSync(filePath, `${JSON.stringify(modList, null, 2)}\n`, 'utf8');
}

function ensureSymlink(linkPath: string, targetPath: string): void {
	const existingPathType = getPathType(linkPath);
	if (existingPathType === 'missing') {
		symlinkSync(targetPath, linkPath);
		return;
	}

	if (existingPathType === 'symlink') {
		const currentTarget = resolve(dirname(linkPath), readlinkSync(linkPath));
		if (currentTarget === resolve(targetPath)) {
			return;
		}
	}

	trashPath(linkPath);
	symlinkSync(targetPath, linkPath);
}

function ensureSavesSymlink(linkPath: string, targetPath: string): void {
	const existingPathType = getPathType(linkPath);
	if (existingPathType === 'missing') {
		symlinkSync(targetPath, linkPath);
		return;
	}

	if (existingPathType === 'symlink') {
		const currentTarget = resolve(dirname(linkPath), readlinkSync(linkPath));
		if (currentTarget === resolve(targetPath)) {
			return;
		}
		trashPath(linkPath);
		symlinkSync(targetPath, linkPath);
		return;
	}

	if (statSync(linkPath).isDirectory()) {
		migrateRunSaves(linkPath, targetPath);
	}

	trashPath(linkPath);
	symlinkSync(targetPath, linkPath);
}

function migrateRunSaves(sourceDir: string, targetDir: string): void {
	const entries = readdirSync(sourceDir, { withFileTypes: true });
	for (const entry of entries) {
		if (entry.name.startsWith('.')) {
			continue;
		}
		if (!entry.isFile()) {
			continue;
		}
		const sourcePath = join(sourceDir, entry.name);
		const targetPath = join(targetDir, entry.name);
		if (!shouldCopySave(sourcePath, targetPath)) {
			continue;
		}
		copyFileSync(sourcePath, targetPath);
		console.log(`Updated canonical save: ${targetPath}`);
	}
}

function shouldCopySave(sourcePath: string, targetPath: string): boolean {
	if (!existsSync(targetPath)) {
		return true;
	}
	return statSync(sourcePath).mtimeMs >= statSync(targetPath).mtimeMs;
}

function getPathType(filePath: string): 'missing' | 'symlink' | 'other' {
	try {
		const stats = lstatSync(filePath);
		return stats.isSymbolicLink() ? 'symlink' : 'other';
	} catch (error) {
		if (isErrnoException(error) && error.code === 'ENOENT') {
			return 'missing';
		}
		throw error;
	}
}

function runFactorio(factorioPath: string, args: string[]): void {
	runCommand([factorioPath, ...args]);
}

function runCommand(command: string[], options: { cwd?: string } = {}): void {
	const [binary, ...args] = command;
	const result = spawnSync(binary, args, {
		cwd: options.cwd,
		stdio: 'inherit',
	});
	if (result.error) {
		fail(`Failed to run "${command.join(' ')}": ${result.error.message}`);
	}
	if (result.status !== 0) {
		process.exit(result.status ?? 1);
	}
}

function trashPath(filePath: string): void {
	const result = spawnSync('trash', [filePath], {
		stdio: 'inherit',
	});
	if (!result.error && result.status === 0) {
		return;
	}

	const reason = result.error ? result.error.message : `exit status ${result.status ?? 'unknown'}`;
	const fallbackPath = `${filePath}.trash-fallback-${Date.now()}`;
	try {
		console.warn(`trash failed (${reason}), moving aside: ${filePath} -> ${fallbackPath}`);
		renameSync(filePath, fallbackPath);
	} catch (error) {
		fail(`Failed to remove path: ${filePath}. ${reason}. ${(error as Error).message}`);
	}
}

function isExecutable(filePath: string): boolean {
	try {
		accessSync(filePath, fsConstants.X_OK);
		return true;
	} catch {
		return false;
	}
}

function assertDirectory(filePath: string, errorMessage: string): void {
	try {
		if (statSync(filePath).isDirectory()) {
			return;
		}
	} catch {
		fail(errorMessage);
	}
	fail(errorMessage);
}

function assertFile(filePath: string, errorMessage: string): void {
	try {
		if (statSync(filePath).isFile()) {
			return;
		}
	} catch {
		fail(errorMessage);
		return;
	}
	fail(errorMessage);
}

function ensureDirectory(dirPath: string): void {
	const pathType = getPathType(dirPath);
	if (pathType === 'missing') {
		mkdirSync(dirPath, { recursive: true });
		return;
	}
	if (pathType === 'symlink') {
		trashPath(dirPath);
		mkdirSync(dirPath, { recursive: true });
		return;
	}
	try {
		if (statSync(dirPath).isDirectory()) {
			return;
		}
	} catch {
		// handled below
	}
	trashPath(dirPath);
	mkdirSync(dirPath, { recursive: true });
}

function isErrnoException(error: unknown): error is NodeJS.ErrnoException {
	return typeof error === 'object' && error !== null && 'code' in error;
}

function fail(message: string): never {
	console.error(message);
	process.exit(1);
}
