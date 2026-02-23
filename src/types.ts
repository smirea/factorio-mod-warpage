declare global {
	type ThermiteQueuedBlast = {
		id: number;
		surface_index: number;
		position: { x: number; y: number };
		force_name: string;
		trigger_tick: number;
		flame_unit_number?: number;
		tooltip_anchor_unit_number?: number;
	};

	type ThermiteMiningState = {
		next_blast_id: number;
		pending_blasts: Record<number, ThermiteQueuedBlast | undefined>;
		tooltip_anchor_cleanup_ticks: Record<number, number | undefined>;
		unlock_bonus_delivered: boolean;
	};

	type ModStorage = {
		thermite_mining: ThermiteMiningState;
		thermite_research_finished_tick: number;
		thermite_support_timeout?: number;
		last_calcite_rescue_tick?: number;
	};

	const storage: ModStorage;

	/** Build time macro evals to `path.join(__dirname, ...parts)` since there is no __dirname natively */
	const DIR_PATH_JOIN: (...parts: string[]) => string;

	/** Build time macro evals to [`${section}.${key}`, ...args] after checking that the locale exists */
	const LOCALE: (section: string, key: string, ...args: Array<string | number>) => [string, ...(string | number)[]];
}
