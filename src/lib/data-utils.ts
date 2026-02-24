// can be safely used in the data stage

import * as util from 'util';

export function extend<T extends Record<string, any> | undefined>(
	base: T,
	diff?: Partial<NonNullable<T>>,
): NonNullable<T> {
	if (!base) throw new Error('must pass a table');

	const clone = util.copy(base);
	if (!clone) throw new Error('util.copy() failed');

	if (diff) Object.assign(clone, diff);

	return clone;
}
