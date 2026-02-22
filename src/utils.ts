type NthTickEventData = { // importing from factorio:runtime causes a module not found error during launch
    readonly tick: number;
    readonly nth_tick: number;
};

const nthTickHandlers: Record<number, {
    fn: (event: NthTickEventData) => void;
    handlers: Array<(event: NthTickEventData) => void>;
}> = {};

export function on_nth_tick(tick: number, handler: (event: NthTickEventData) => void) {
    if (!nthTickHandlers[tick]) {
        nthTickHandlers[tick] = {
            fn: event => nthTickHandlers[tick]?.handlers.forEach(h => h(event)),
            handlers: [],
        };
        script.on_nth_tick(tick, nthTickHandlers[tick].fn);
    }

    nthTickHandlers[tick].handlers.push(handler);

    return () => {
        if (!nthTickHandlers[tick]) return;
        nthTickHandlers[tick].handlers = nthTickHandlers[tick].handlers.filter(h => h !== handler);
    };
}

const onEventHandlers: Record<string, {
    fn: (event: any) => void;
    handlers: Array<(event: any) => void>;
}> = {};

export function on_event<Type extends keyof typeof defines.events>(
    type: Type,
    handler: (event: typeof defines.events[Type]) => void,
    filters: Array<typeof defines.events[Type]['_filter']>
) {
    if (!onEventHandlers[type]) {
        onEventHandlers[type] = {
            fn: event => onEventHandlers[type]?.handlers.forEach(h => h(event)),
            handlers: [],
        };
        script.on_event(defines.events[type] as any, onEventHandlers[type].fn, filters);
    }

    onEventHandlers[type].handlers.push(handler);

    return () => {
        if (!onEventHandlers[type]) return;
        onEventHandlers[type].handlers = onEventHandlers[type].handlers.filter(h => h !== handler);
        if (onEventHandlers[type].handlers.length === 0) script.on_event(defines.events[type], undefined);
    };
}
