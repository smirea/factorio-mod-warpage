This is a Factorio: Space Age mod using [typed factorio](https://github.com/GlassBricks/typed-factorio) and [typescript-to-lua](https://typescripttolua.github.io/)

This is a hobby mod, not a nuclear reactor. keep things simple, do not over-complicate, avoid tedious future proofing or extensibility unless explicitly needed

High level design documennts available under `./project/*`, they were true at the time of implementation, don't treat them as gospel, use git history to check updates when they conflict and ask me for clarification if there is still discrapancy, update feature projects to fix discrepancies once resolved.

# Things to keep in mind

- automatic pre-commit hooks: lint (oxlint --fix), format (oxfmt), build (scripts/build.ts)
- there is a `./scripts/build.ts` processing step together with `./scripts/tstlPlugin.cjs` that handles TS to Lua, static files, sanity checks and build time macros
- there is a `./scripts/launch.ts` script that can be also run in headless mode that handles mod and save linking and other launch goodies
- you should rely on the built-in utilities over their native counterparts where possible (`src/lib/utils.ts` for working with events, research, etc and `src/lib/data-utils.ts` for prototype manipulation during data stage)
- localization under `locale/en/warpage.cfg`, custom `LOCALE(namespace, key, ...args)` build time macro that validates against the file
- factorio data path: `/Applications/factorio.app/Contents/data` (for referencing canonical assets)
