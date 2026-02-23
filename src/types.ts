declare global {
	/**
	 * saved stated for this mod only, update the type as needed
	 * @see https://lua-api.factorio.com/latest/auxiliary/storage.html
	 */
	type ModStorage = {};

	const storage: ModStorage;

	/** Build time macro evals to `path.join(__dirname, ...parts)` since there is no __dirname natively */
	const DIR_PATH_JOIN: (...parts: string[]) => string;

	/** Build time macro evals to [`${section}.${key}`, ...args] after checking that the locale exists */
	const LOCALE: (section: string, key: string, ...args: Array<string | number>) => [string, ...(string | number)[]];
}
