export default {
	meta: {
		name: 'factorio',
	},
	rules: {
		'no-restricted-api': {
			create(context) {
				const restrictions = compileRestrictions(context.options);
				if (restrictions.length === 0) return {};

				return {
					CallExpression(node) {
						const apiPath = getApiPath(node.callee);
						if (!apiPath) return;

						const match = restrictions.find(restriction => restriction.pattern === apiPath);
						if (match)
							context.report({
								message: match.message,
								node,
							});
					},
				};
			},
			meta: {
				docs: {
					description: 'Disallow usage of restricted APIs in `namespace.functioncall()` form.',
				},
				schema: [
					{
						items: {
							additionalProperties: false,
							properties: {
								message: { minLength: 1, type: 'string' },
								pattern: {
									minLength: 1,
									pattern: '^[A-Za-z_$][A-Za-z0-9_$]*\\.[A-Za-z_$][A-Za-z0-9_$]*\\(\\)$',
									type: 'string',
								},
							},
							required: ['pattern', 'message'],
							type: 'object',
						},
						type: 'array',
					},
				],
				type: 'problem',
			},
		},
	},
};

function compileRestrictions(options) {
	const configured = Array.isArray(options?.[0]) ? options[0] : [];
	return configured
		.filter(
			restriction =>
				restriction &&
				typeof restriction.pattern === 'string' &&
				isPatternSupported(restriction.pattern) &&
				typeof restriction.message === 'string' &&
				restriction.message.length > 0,
		)
		.map(restriction => ({
			pattern: restriction.pattern,
			message: restriction.message,
		}));
}

function isPatternSupported(pattern) {
	return /^[A-Za-z_$][A-Za-z0-9_$]*\.[A-Za-z_$][A-Za-z0-9_$]*\(\)$/.test(pattern);
}

function getApiPath(expression) {
	if (!expression || typeof expression !== 'object') return undefined;

	if (expression.type === 'ChainExpression') return getApiPath(expression.expression);

	if (expression.type !== 'MemberExpression') return undefined;

	if (expression.computed) return undefined;

	if (expression.object.type !== 'Identifier' || expression.property.type !== 'Identifier') return undefined;

	return `${expression.object.name}.${expression.property.name}()`;
}
