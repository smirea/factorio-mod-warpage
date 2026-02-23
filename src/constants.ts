export const modRoot = '__warpage__' as const;
export const modPath = (str: string) => modPath + '/' + str;

const ns = 'warpage-' as const;
export const nsFactory = <const Prefix extends string>(prefix: string) =>
	Object.assign(<const T extends string>(str: T): `${Prefix}${T}` => (prefix + str) as any, {
		ns: <const P2 extends string>(p2: P2) => nsFactory<`${Prefix}${P2}`>(prefix + p2),
	});
export const modNs = nsFactory<typeof ns>(ns);
