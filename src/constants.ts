const ns = 'warpage' as const;

export const nsFactory =
	<const Prefix extends string>(prefix: Prefix) =>
	<const Value extends string>(str?: Value): Value extends string ? `${Prefix}-${Value}` : Prefix =>
		(str == null ? prefix : `${prefix}-${str}`) as any;

export const modNs = nsFactory(ns);
