const ts = require('typescript');
const tstl = require('typescript-to-lua');
const path = require('node:path');
const fs = require('node:fs');

const srcDir = path.join(__dirname, '..', 'src');

const modName = require(path.join(__dirname, '..', 'info.json')).name;

if (!modName) throw new Error('info.json must have a "name" field');

const localeFilePath = path.join(__dirname, '..', 'locale', 'en', `${modName}.cfg`);
const localeNamespacePrefix = `${modName}-`;
const red = '\x1b[31m';
const reset = '\x1b[0m';

if (!fs.existsSync(localeFilePath)) throw new Error(`Missing locale file: ${localeFilePath}`);

const localeSections = parseLocaleFile(localeFilePath);
const warnedMissingLocales = new Set();
const warnedPrefixedLocales = new Set();

/** @type import("typescript-to-lua").Plugin */
const plugin = {
	visitors: {
		[ts.SyntaxKind.CallExpression]: (node, context) => {
			if (!ts.isIdentifier(node.expression)) return context.superTransformExpression(node);
			if (node.expression.text !== 'DIR_PATH_JOIN' && node.expression.text !== 'LOCALE')
				return context.superTransformExpression(node);

			const sourceFile = node.getSourceFile();
			const fileName = sourceFile?.fileName ?? '<unknown>';

			switch (node.expression.text) {
				case 'DIR_PATH_JOIN': {
					const parts = node.arguments.map(arg => (ts.isStringLiteralLike(arg) ? arg.text : undefined));
					if (!parts.length) throw new Error('DIR_PATH_JOIN() must have at least one argument in: ' + fileName);
					if (parts.some(part => part === undefined))
						throw new Error('DIR_PATH_JOIN() only accepts string arguments in: ' + fileName);

					const sourceDir = path.dirname(fileName);
					if (!sourceDir.startsWith(srcDir)) throw new Error(`DIR_PATH_JOIN('${parts.join(', ')}') not in mod dir`);

					const value = path.join(`__${modName}__`, sourceDir.replace(srcDir + path.sep, ''), ...parts);
					return tstl.createStringLiteral(value, node);
				}
				case 'LOCALE': {
					if (node.arguments.length < 2) throw new Error('LOCALE() must have at least 2 arguments at: ' + fileName);

					const [sectionArg, keyArg, ...args] = node.arguments;
					if (!ts.isStringLiteralLike(sectionArg) || !ts.isStringLiteralLike(keyArg))
						throw new Error('LOCALE() first two arguments must be string literals at: ' + fileName);

					const namespacedKey = keyArg.text.startsWith(localeNamespacePrefix)
						? (warnPrefixedLocaleKey(keyArg.text, fileName, node), keyArg.text)
						: localeNamespacePrefix + keyArg.text;
					warnMissingLocale(sectionArg.text, namespacedKey, fileName, node);
					const localeKey = `${sectionArg.text}.${namespacedKey}`;
					const fields = [
						tstl.createTableFieldExpression(tstl.createStringLiteral(localeKey, node)),
						...args.map(arg => tstl.createTableFieldExpression(transformLocaleArg(arg, context))),
					];
					return tstl.createTableExpression(fields, node);
				}
			}

			return context.superTransformExpression(node);
		},
	},
};

module.exports = plugin;

function transformLocaleArg(arg, context) {
	const transformed = context.transformExpression(arg);
	const argType = context.checker.getTypeAtLocation(arg);
	if (!isNumberLikeType(argType)) return transformed;

	return tstl.createCallExpression(tstl.createIdentifier('tostring', arg), [transformed], arg);
}

function isNumberLikeType(type) {
	if ((type.flags & ts.TypeFlags.NumberLike) !== 0) return true;

	if (type.isUnionOrIntersection()) return type.types.some(isNumberLikeType);

	return false;
}

function parseLocaleFile(filePath) {
	const sections = new Map();
	const lines = fs.readFileSync(filePath, 'utf8').split(/\r?\n/);
	let currentSection = '';

	for (const line of lines) {
		const trimmed = line.trim();
		if (!trimmed || trimmed.startsWith(';')) continue;

		const sectionMatch = /^\[([^\]]+)\]$/.exec(trimmed);
		if (sectionMatch) {
			currentSection = sectionMatch[1].trim();
			if (!sections.has(currentSection)) sections.set(currentSection, new Set());
			continue;
		}

		if (!currentSection) continue;

		const separatorIndex = trimmed.indexOf('=');
		if (separatorIndex < 1) continue;

		const key = trimmed.slice(0, separatorIndex).trim();
		if (!key) continue;
		sections.get(currentSection).add(key);
	}

	return sections;
}

function warnMissingLocale(section, key, fileName, node) {
	if (localeSections.get(section)?.has(key)) return;

	const sourceFile = node.getSourceFile();
	if (!sourceFile) return;
	const location = sourceFile.getLineAndCharacterOfPosition(node.getStart());
	const warningKey = `${fileName}:${location.line}:${location.character}:${section}.${key}`;
	if (warnedMissingLocales.has(warningKey)) return;

	warnedMissingLocales.add(warningKey);
	warnInRed(
		`[tstlPlugin] Missing locale key "${section}.${key}" in ${localeFilePath} (used at ${fileName}:${location.line + 1}:${location.character + 1})`,
	);
}

function warnPrefixedLocaleKey(key, fileName, node) {
	const sourceFile = node.getSourceFile();
	if (!sourceFile) return;
	const location = sourceFile.getLineAndCharacterOfPosition(node.getStart());
	const warningKey = `${fileName}:${location.line}:${location.character}:${key}`;
	if (warnedPrefixedLocales.has(warningKey)) return;

	warnedPrefixedLocales.add(warningKey);
	warnInRed(
		`[tstlPlugin] LOCALE() key "${key}" should not include "${localeNamespacePrefix}" (used at ${fileName}:${location.line + 1}:${location.character + 1})`,
	);
}

function warnInRed(message) {
	console.warn(red + message + reset);
}
