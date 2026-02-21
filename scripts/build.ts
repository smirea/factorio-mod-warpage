#!/usr/bin/env bun

import { execSync, type ExecSyncOptionsWithBufferEncoding } from 'node:child_process';
import path, { dirname, join, resolve } from 'node:path';
import fs from 'node:fs';
import { fileURLToPath } from 'node:url';

const scriptDir = dirname(fileURLToPath(import.meta.url));
const rootDir = resolve(scriptDir, '..');
const srcDir = join(rootDir, 'src');

const tsFiles = cmd(`find ${srcDir} -type f -name '*.ts'`, { stdio: undefined }).split('\n');

const mustImportNames = ['control.ts', 'data-final-fixes.ts', 'data-updates.ts', 'data.ts'];

const errors: string[] = [];
for (const file of tsFiles) {
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
	if (!canonical.includes(importString)) {
		errors.push(`src/${fileName} is missing \`${importString}\``);
	}
}

if (errors.length > 0) {
	console.error('Errors:');
	for (const error of errors) {
		console.error(error);
	}
	process.exit(1);
}

cmd(`rm -rf compiled`);
cmd(`./node_modules/.bin/tstl`);
cmd(`cp info.json thumbnail.png compiled`);

function cmd(str: string, args?: ExecSyncOptionsWithBufferEncoding) {
	return execSync(str, { cwd: rootDir, stdio: 'inherit', ...args })
		?.toString()
		.trim();
}
