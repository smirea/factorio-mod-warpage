This is a Factorio: Space Age mod using [typed factorio](https://github.com/GlassBricks/typed-factorio) and [typescript-to-lua](https://typescripttolua.github.io/)

This is a hobby mod, not a nuclear reactor. keep things simple, do not over-complicate, avoid tedious future proofing or extensibility unless explicitly needed. Do not write excessive checks, don't use top level constants unless they are re-used in multiple functions or are explcitly requested. Never check `entity.valid` unless it explicitly causes a bug

High level design documennts available under `./project/*`, they were true at the time of implementation, don't treat them as gospel, use git history to check updates when they conflict and ask me for clarification if there is still discrapancy, update feature projects to fix discrepancies once resolved.

# Things to keep in mind

- automatic pre-commit hooks: lint (oxlint --fix), format (oxfmt), build (scripts/build.ts)
- there is a `./scripts/build.ts` processing step together with `./scripts/tstlPlugin.cjs` that handles TS to Lua, static files, sanity checks and build time macros
- there is a `./scripts/launch.ts` script that can be also run in headless mode that handles mod and save linking and other launch goodies
- you should rely on the built-in utilities over their native counterparts where possible (`src/lib/utils.ts` for working with events, research, etc and `src/lib/data-utils.ts` for prototype manipulation during data stage)
- localization under `locale/en/warpage.cfg`, custom `LOCALE(namespace, key, ...args)` build time macro that validates against the file
- factorio data path: `/Applications/factorio.app/Contents/data` (for referencing canonical assets)
- prefer absolute imports using `@` alias outside of modules, so `import '@/lib/utils'` instead of `import './lib/utils'`

# Factorio references

Use these as source-of-truth references when implementing mechanics, prototypes, settings, and runtime scripting or needing to reference anything about the factorio behavior or API.

## Official API docs (primary source of truth)

- typed-factorio (TS to Lua bridge): https://raw.githubusercontent.com/GlassBricks/typed-factorio/refs/heads/main/README.md
- Runtime API index: https://lua-api.factorio.com/latest/
- Prototype API index: https://lua-api.factorio.com/latest/index-prototype.html
- Auxiliary docs index: https://lua-api.factorio.com/latest/index-auxiliary.html
- Data lifecycle: https://lua-api.factorio.com/latest/auxiliary/data-lifecycle.html
- Mod structure: https://lua-api.factorio.com/latest/auxiliary/mod-structure.html
- Storage (persistent state): https://lua-api.factorio.com/latest/auxiliary/storage.html
- Libraries/`require()` behavior: https://lua-api.factorio.com/latest/auxiliary/libraries.html
- Events enum reference: https://lua-api.factorio.com/latest/defines.html#defines.events

## Factorio wiki (secondary reference)

- Modding tutorial: https://wiki.factorio.com/Tutorial:Modding_tutorial/Gangsir
- Scripting tutorial: https://wiki.factorio.com/Tutorial:Scripting
- Localisation tutorial: https://wiki.factorio.com/Tutorial:Localisation
- Scenario system: https://wiki.factorio.com/Scenario_system
- `data.raw` reference page: https://wiki.factorio.com/Data.raw
- Command-line parameters: https://wiki.factorio.com/Command_line_parameters

## Other useful official sources

- Mod Portal: https://mods.factorio.com/
- Official forums: https://forums.factorio.com/

## Local offline docs (from installed Factorio)

- Runtime docs: `<factorio.app>/Contents/doc-html/index-runtime.html`
- Prototype docs: `<factorio.app>/Contents/doc-html/index-prototype.html`
- Auxiliary docs: `<factorio.app>/Contents/doc-html/index-auxiliary.html`

When there is any conflict, prefer the official `lua-api.factorio.com` docs over wiki/community content.
