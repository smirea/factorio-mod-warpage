#!/usr/bin/env bun

import { execSync, type ExecSyncOptionsWithBufferEncoding } from 'node:child_process';
import path from 'node:path';
import fs from 'node:fs';
import { fileURLToPath } from 'node:url';

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.resolve(scriptDir, '..');
const srcDir = path.join(rootDir, 'src');

const mustImportNames = ['control.ts', 'data-final-fixes.ts', 'data-updates.ts', 'data.ts'];
const toCopy: string[] = ['locale', 'info.json', 'thumbnail.png'];
const allFiles = cmd(`find ${srcDir} -type f`, { stdio: undefined }).split('\n');

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
	const canonical = fs.readFileSync(canonicalPath);
	if (!canonical.includes(importString)) errors.push(`src/${fileName} is missing \`${importString}\``);
}

if (errors.length > 0) {
	console.error('Errors:');
	for (const error of errors) console.error(error);

	process.exit(1);
}

cmd(`rm -rf compiled`);
cmd(`./node_modules/.bin/tstl`);

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

function cmd(str: string, args?: ExecSyncOptionsWithBufferEncoding) {
	return execSync(str, { cwd: rootDir, stdio: 'inherit', ...args })
		?.toString()
		.trim();
}
