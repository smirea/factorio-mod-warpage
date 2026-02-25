declare global {
	type ModStorage = {
		surface: string;
		hubRepaired: boolean;
		startupSuppliesSeeded: boolean;
		startConfiguredPlayerIndices: Record<number, true | undefined>;
	};

	const storage: ModStorage;

	/** Build time macro evals to `path.join(__dirname, ...parts)` since there is no __dirname natively */
	const DIR_PATH_JOIN: (...parts: string[]) => string;

	/** Build time macro evals to [`${section}.${key}`, ...args] after checking that the locale exists */
	const LOCALE: (section: string, key: string, ...args: Array<string | number>) => [string, ...(string | number)[]];
}
