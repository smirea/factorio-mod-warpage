This is a factorio mod called "Warp Age", this repository contains a Factorio 2.0-ready scaffold with strict stage routing and feature-local modules.

See `project/README.md` for high level goals, big picture, and scope. See `project/feature_*.md` for feature details.

# Coding guidelines

1. When writing lua, always define proper types for everything by referencing the correct factorio entity and return types
2. When writing new functionality check ./core and especially ./core/utils first to see what can be re-used and how to work within the existing framework
3. Do not add explicit guard checks for guaranteed invariants. If something should exist by design (known surfaces, entities, forces, settings, schema fields), use it directly and let native errors surface. Optional arguments and intentionally optional compatibility paths are fine. Rely on the type system, do not verify that the type system is working at runtime, assume it is (for example, don't check that the shape of a table matches its type if the type is detailed)
4. Error on the side of simpler reusable code
5. Do not alias variables for the sake of aliasing. Especially prevalent for imports
  - bad example: `local someImportNs = require('some.import.ns'); local foo = someImportNs.foo; foo();`
  - good example: `local someImportNs = require('some.import.ns'); someImportNs.foo();`
6. use hoisted constants mindfully. hoist constants for important configuration, avoid hoisting for any sort of value
7. Do not create pass-through wrappers. If a local function only forwards to another call, call the target directly.

# Typing and static checks

- This repo uses LuaLS + LuaCATS as the source-of-truth type system for Lua code.
- Workspace LuaLS configuration lives in `.luarc.json`.
- Generated Factorio LuaCATS stubs live in `.luals/factorio` and are included via `.luarc.json` workspace library settings.
- Regenerate stubs when API docs/version changes with:
  - `node ./scripts/generate-factorio-luacats-stubs.mjs`
- Shared project type aliases/classes live in `types/warpage.lua`.
- Prefer annotating function parameters/returns and structural tables at module boundaries, especially module registration tables, contexts, event registrations, and storage schemas.
- When adding new typed shared structures, define them in `types/warpage.lua` first and then consume them from module/core modules.

# Required local verification

- Run LuaLS checks before commit:
  - `lua-language-server --configpath .luarc.json --check . --checklevel=Warning`
- Run luacheck before commit:
  - `luacheck control.lua data.lua data-updates.lua data-final-fixes.lua settings.lua settings-updates.lua settings-final-fixes.lua core modules tests types`
- Run ship integration tests before commit on a dedicated test save with `warpage-enable-ship-tests=true`:
  - `LAUNCH_ROOT=./.tmp/factorio-test-headless HEADLESS=1 UNTIL_TICK=6000 ./scripts/launch.sh warpage-ship-tests`
  - `UNTIL_TICK` must be greater than the current map tick of that save.
  - Verify `./.tmp/factorio-test-headless/write-data/factorio-current.log` contains `[warpage] ship tests passed`.
- Run `HEADLESS=1 ./scripts/launch.sh` to check game boots up

# Running Ship Tests

1. Create or load a dedicated save for tests (recommended name: `warpage-ship-tests`).
2. In that save, open Mod settings and set runtime-global `warpage-enable-ship-tests` to `true`.
3. Save and quit.
4. Run headless:
   - `LAUNCH_ROOT=./.tmp/factorio-test-headless HEADLESS=1 UNTIL_TICK=6000 ./scripts/launch.sh warpage-ship-tests`
   - Ensure `UNTIL_TICK` is greater than the save's current map tick.
5. Confirm log output includes `[warpage] ship tests passed` and no non-recoverable errors.
6. Use a fresh/reset dedicated test save when validating the pass marker; the ship test state is persisted in storage.

# Git hooks

- Pre-commit is managed via `lefthook.yml`.
- The `luals-staged` pre-commit command checks only staged `.lua` files using `scripts/check-lua-staged.sh`.
- `scripts/check-lua-staged.sh` resolves `lua-language-server` from PATH, `LUA_LANGUAGE_SERVER_BIN`, Mason install, or Cursor extension install.

## Folder layout

- `info.json`: mod metadata and dependency contract.
- `settings.lua`, `settings-updates.lua`, `settings-final-fixes.lua`: settings stage entry points.
- `data.lua`, `data-updates.lua`, `data-final-fixes.lua`: prototype stage entry points.
- `control.lua`: runtime entry point.
- `core`: shared framework utilities.
- `modules/<feature-name>`: all code for one feature.

## Core framework

- `core/feature_loader.lua` defines explicit module registrations per stage and dispatches stage handlers.
- `core/runtime.lua` creates the shared event bus and invokes runtime feature handlers.
- `core/event_bus.lua` provides source-scoped runtime bindings per feature.

## Core utils

- `core/utils/common.lua` contains shared fail-fast helpers. Import once as `local common = require("core.utils.common")` and call helpers directly (`common.ensure_table(...)`, etc).
- `core/utils/compound_entity.lua` handles compound-entity placement, syncing, cleanup, and event wiring.
- For compound entities in control stage, bind through feature-scoped events (`compound:bind(context.events)`) so event registration remains source-scoped.

## Module registration

Modules do not use manifest files. Register module files directly in `core/feature_loader.lua`.

- `control_modules`: runtime control stage runners.
- Current control flow uses `modules.startup` as the control runner, and startup invokes ship setup.
- `module_entity_module_paths`: module-owned entity prototype lists.
- `module_recipe_module_paths`: module-owned recipe prototype lists.

Shared cross-module prototypes live in `data/entities/init.lua` and `data/recipes/init.lua`.

## Runtime feature context

Control-stage modules receive one context table with:

- `feature_id`
- `feature_module_path`
- `stage`
- `events`: source-scoped event binder for the feature

`events` exposes:

- `on_init(handler)`
- `on_load(handler)`
- `on_configuration_changed(handler)`
- `on_event(event_id, handler)`
- `on_nth_tick(tick, handler)`
- `bind({ ... })` for bulk registration

## Adding a new module

1. Create module files directly (commonly `modules/<new_module>/control.lua`, `modules/<new_module>/entities.lua`, `modules/<new_module>/recipes.lua`).
2. Register prototype modules in `core/feature_loader.lua` (`module_entity_module_paths` / `module_recipe_module_paths`) as needed.
3. For runtime behavior, either wire the module from `modules/startup.lua` (preferred orchestration path) or add a control registration in `core/feature_loader.lua` intentionally.
4. Put runtime-global settings in top-level `settings.lua` when needed.
5. In control modules, register events through `context.events`.
6. If runtime state is needed, initialize schema in `on_init` and validate in `on_load`.
7. Run `HEADLESS=1 ./scripts/launch.sh` to make sure game boots up

## Launching for development

- Run `./scripts/launch.sh` to launch Factorio with the mod in minimal debug mode.
- Defaults:
  - save name: `warpage-test`
  - flags: `--verbose` and `--disable-audio`
  - profile: `.tmp/factorio-launch`
- The script auto-detects Factorio binaries (standalone installs first, Steam fallback last). Override explicitly with `FACTORIO_BIN=/path/to/factorio`.
- If the target save does not exist, it creates one automatically with the same debug mod set (`base` + `elevated-rails` + `quality` + `space-age` + `warpage`).
- Run `HEADLESS=1 ./scripts/launch.sh` for a quick non-interactive startup check (`UNTIL_TICK` defaults to `120`); if the save is already past that tick, increase `UNTIL_TICK`.

# Factorio references

Use these as source-of-truth references when implementing mechanics, prototypes, settings, and runtime scripting.

## Official API docs (primary source of truth)

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
