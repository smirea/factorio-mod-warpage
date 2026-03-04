const ns = 'warpage' as const;

export const nsFactory =
	<const Prefix extends string>(prefix: Prefix) =>
	<const Value extends string | undefined = undefined>(
		str?: Value,
	): Value extends string ? `${Prefix}-${Value}` : Prefix =>
		(str == null ? prefix : `${prefix}-${str}`) as any;

export const modNs = nsFactory(ns);

export function makeEnum<const Prefix extends string, const Arr extends string[]>(
	prefix: Prefix,
	arr: Arr,
): { [K in Arr[number]]: `${Prefix}-${K}` } {
	const result: Record<string, string> = {};
	for (const key of arr) result[key] = prefix + '-' + key;
	return result as any;
}
