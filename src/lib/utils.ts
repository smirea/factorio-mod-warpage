import type {
	BaseGuiElement,
	EventData,
	LocalisedString,
	LuaEntity,
	LuaSurface,
	MapPosition,
	OnGuiClickEvent,
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
			filters,
		};
		// oxlint-disable-next-line factorio/no-restricted-api
		script.on_event(
			defines.events[type] as any,
			event => {
				onEventHandlers[type]?.handlers.forEach(h => h(event));
			},
			filters,
		);
	} else if (filters || onEventHandlers[type].filters)
		throw new Error(
			`you cannot register multiple on_event(${type}) when using event filters, either remove the filters or use a single event handler`,
		);

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
	if (onInitEvents.length === 1)
		// oxlint-disable-next-line factorio/no-restricted-api
		script.on_init(() => {
			onInitEvents.forEach(h => h());
		});
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

/**
 * useful when debugging in game
 * @see https://typescripttolua.github.io/docs/assigning-global-variables
 */
export function registerGlobal(name: string, value: any) {
	// @ts-ignore
	globalThis[name] = value;
}

type GuiEvent = keyof typeof defines.events & `on_gui_${string}`;

export const gui: {
	handlers: Record<GuiEvent, Record<string, (event: OnGuiClickEvent & EventData) => void>>;
	addHandlers: (
		name: string,
		eventNames: GuiEvent[],
		handler: (event: OnGuiClickEvent & EventData) => void,
	) => () => void;
	removeHandlers: (name: string) => void;
	destroy: (element: BaseGuiElement | null | undefined, isChild?: boolean) => void;
} = {
	handlers: {
		on_gui_checked_state_changed: {},
		on_gui_click: {},
		on_gui_closed: {},
		on_gui_confirmed: {},
		on_gui_elem_changed: {},
		on_gui_hover: {},
		on_gui_leave: {},
		on_gui_location_changed: {},
		on_gui_opened: {},
		on_gui_selected_tab_changed: {},
		on_gui_selection_state_changed: {},
		on_gui_switch_state_changed: {},
		on_gui_text_changed: {},
		on_gui_value_changed: {},
	},
	addHandlers: (name, eventNames, handler) => {
		for (const eventName of eventNames) {
			// oxlint-disable-next-line curly
			if (table_size(gui.handlers[eventName]) === 0) {
				on_event(eventName, event => {
					if (!event.element?.valid) return;
					const name = event.element?.name;
					if (name != null) gui.handlers[eventName][name]?.(event as any);
				});
			}
			gui.handlers[eventName][name] = handler;
		}
		return () => {
			for (const eventName of eventNames) delete gui.handlers[eventName][name];
		};
	},
	removeHandlers: name => {
		delete gui.handlers.on_gui_checked_state_changed[name];
		delete gui.handlers.on_gui_click[name];
		delete gui.handlers.on_gui_closed[name];
		delete gui.handlers.on_gui_confirmed[name];
		delete gui.handlers.on_gui_elem_changed[name];
		delete gui.handlers.on_gui_hover[name];
		delete gui.handlers.on_gui_leave[name];
		delete gui.handlers.on_gui_location_changed[name];
		delete gui.handlers.on_gui_opened[name];
		delete gui.handlers.on_gui_selected_tab_changed[name];
		delete gui.handlers.on_gui_selection_state_changed[name];
		delete gui.handlers.on_gui_switch_state_changed[name];
		delete gui.handlers.on_gui_text_changed[name];
		delete gui.handlers.on_gui_value_changed[name];
	},
	/** works just like `BaseGuiElement.destroy()` but recursively goes through and de-registers all handlers by name */
	destroy: (element, isChild) => {
		if (!element) return;
		gui.removeHandlers(element.name);
		if (!element.valid) return;
		for (const child of element.children || []) gui.destroy(child);
		if (!isChild) element.destroy();
	},
};

export function parseBlueprint(blueprintString: string): {
	icons?: any[];
	tiles?: Array<{ name: string; position: { x: number; y: number } }>;
	entities?: Array<{ entity_number: number; name: string; position: { x: number; y: number } }>;
	wires?: Array<[number, number, number, number]>;
} {
	if (blueprintString[0] === '0') blueprintString = blueprintString.slice(1);
	const decoded = helpers.decode_string(blueprintString);
	if (!decoded) throw new Error('cannot decode blueprint string');
	const result = helpers.json_to_table(decoded);
	if (result == null) throw new Error('json_to_table() failed to parse');
	if (typeof result !== 'object') throw new Error('blueprint string not an object');
	if ((result as any).blueprint == null) throw new Error('blueprint string does not have a "blueprint" property');
	return (result as any).blueprint;
}
