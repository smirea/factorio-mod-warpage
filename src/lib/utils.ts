import type {
	LocalisedString,
	LuaEntity,
	LuaSurface,
	MapPosition,
	SpeechBubbleEntity,
	SurfaceCreateEntity,
} from 'factorio:runtime';

type NthTickEventData = {
	// importing from factorio:runtime causes a module not found error during launch
	readonly tick: number;
	readonly nth_tick: number;
};

const nthTickHandlers: Record<
	number,
	{
		handlers: Array<(event: NthTickEventData) => void>;
	}
> = {};

/**
 * convenience wrapper on top of `script.on_nth_tick()` that allows multiple modules to register events
 *
 * @see script.on_event
 */
export function on_nth_tick(tick: number, handler: (event: NthTickEventData) => void) {
	if (!nthTickHandlers[tick] || nthTickHandlers[tick].handlers.length === 0) {
		nthTickHandlers[tick] = {
			handlers: [],
		};
		// oxlint-disable-next-line factorio/no-restricted-api
		script.on_nth_tick(tick, event => {
			nthTickHandlers[tick]?.handlers.forEach(h => h(event));
		});
	}

	nthTickHandlers[tick].handlers.push(handler);

	return () => {
		if (!nthTickHandlers[tick]) return;
		nthTickHandlers[tick].handlers = nthTickHandlers[tick].handlers.filter(h => h !== handler);
		if (nthTickHandlers[tick].handlers.length === 0) {
			// oxlint-disable-next-line factorio/no-restricted-api
			script.on_nth_tick(tick, undefined);
			delete nthTickHandlers[tick];
		}
	};
}

const onEventHandlers: Record<
	string,
	{
		handlers: Array<(event: any) => void>;
		filters?: any;
	}
> = {};

/**
 * convenience wrapper on top of `script.on_event()` that allows multiple modules to register events
 *
 * @see script.on_event
 */
export function on_event<Type extends keyof typeof defines.events>(
	type: Type,
	handler: (event: (typeof defines.events)[Type]['_eventData']) => void,
	filters?: Array<(typeof defines.events)[Type]['_filter']>,
) {
	if (!onEventHandlers[type]) {
		onEventHandlers[type] = {
			handlers: [],
		};
		// oxlint-disable-next-line factorio/no-restricted-api
		script.on_event(
			defines.events[type] as any,
			event => {
				onEventHandlers[type]?.handlers.forEach(h => h(event));
			},
			filters,
		);
	} else if (filters || onEventHandlers[type].filters) {
		throw new Error(
			`you cannot register multiple on_event(${type}) when using event filters, either remove the filters or use a single event handler`,
		);
	}

	onEventHandlers[type].handlers.push(handler);

	return () => {
		if (!onEventHandlers[type]) return;
		onEventHandlers[type].handlers = onEventHandlers[type].handlers.filter(h => h !== handler);
		if (onEventHandlers[type].handlers.length === 0) {
			delete onEventHandlers[type];
			// oxlint-disable-next-line factorio/no-restricted-api
			script.on_event(defines.events[type], undefined);
		}
	};
}

const onInitEvents: Array<() => void> = [];
/**
 * convenience wrapper on top of `script.on_init()` to allow multiple handlers
 */
export function on_init(handler: () => void) {
	onInitEvents.push(handler);
	if (onInitEvents.length === 1) {
		// oxlint-disable-next-line factorio/no-restricted-api
		script.on_init(() => {
			onInitEvents.forEach(h => h());
		});
	}
}

export function createHolographicText({
	target,
	text,
	ticks,
	offset,
}: {
	target: LuaEntity;
	text: LocalisedString;
	ticks: number;
	offset?: MapPosition;
}) {
	return target.surface.create_entity({
		name: 'compi-speech-bubble',
		position: {
			x: target.position.x + (offset?.x ?? 0),
			y: target.position.y + (offset?.y ?? 0),
		},
		target,
		text,
		lifetime: ticks,
	} as any) as SpeechBubbleEntity;
}

/**
 * Convenience wrapper on top of `surface.create_entity()` that asserts entity exists
 */
export function createEntity<T = LuaEntity>(surface: LuaSurface, params: SurfaceCreateEntity): T {
	// oxlint-disable-next-line factorio/no-restricted-api
	const entity = surface.create_entity({
		force: 'player',
		...params,
	});
	if (!entity) throw new Error(`failed to create entity.name=${params.name} on surface ${surface.name}`);
	return entity as any;
}

export function getCurrentSurface(surfaceName = storage.surface) {
	const surface = game.surfaces[surfaceName];
	if (!surface) throw new Error(`Missing surface '${surfaceName}'.`);
	return surface;
}

/**
 * useful when debugging in game
 * @see https://typescripttolua.github.io/docs/assigning-global-variables
 */
export function registerGlobal(name: string, value: any) {
	// @ts-ignore
	globalThis[name] = value;
}
