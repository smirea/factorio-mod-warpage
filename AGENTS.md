This is a factorio mod called "Warp Age"

See `project.md` for high level goals, big picture, project scope

## Mod architecture

This repository contains a Factorio 2.0-ready scaffold with strict stage routing and feature-local modules.

### Folder layout

- `info.json`: mod metadata and dependency contract.
- `settings.lua`, `settings-updates.lua`, `settings-final-fixes.lua`: settings stage entry points.
- `data.lua`, `data-updates.lua`, `data-final-fixes.lua`: prototype stage entry points.
- `control.lua`: runtime entry point.
- `core`: shared framework utilities.
- `features/<feature-name>`: all code for one feature.

### Core framework

- `feature_index.lua` defines feature load order.
- `core/feature_loader.lua` validates feature manifests, validates stage keys, and dispatches stage handlers.
- `core/runtime.lua` creates the shared event bus and invokes runtime feature handlers.
- `core/event_bus.lua` provides source-scoped runtime bindings per feature.
- `core/storage_schema.lua` enforces persistent storage structure early.

### Feature contract

Each feature folder contains a `feature.lua` file that returns:

- `id`: unique feature identifier.
- `stages`: map from stage names to module paths.

Each stage module must return one function. The loader errors immediately when contracts are invalid.

### Runtime feature context

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

### Adding a new feature

1. Create `features/<new_feature>/feature.lua` with `id` and `stages`.
2. Add any stage modules referenced by `stages`.
3. Add `<new_feature>` to `feature_index.lua`.
4. In control modules, register events through `context.events`.
5. If runtime state is needed, initialize schema in `on_init` and validate in `on_load`.

### Smoke testing

- Run `./scripts/smoke_test.sh`.
- The script expects a Factorio binary at `/Users/stefan/Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS/factorio` unless overridden by `FACTORIO_BIN`.
- The script uses `/Users/stefan/code/factorio-mods/warpage_0.1.0` as the canonical symlink and validates it points to this repository.
- It creates an isolated temporary profile under `.tmp/factorio-smoke`, runs map create + load in headless mode, and fails on mod-load/runtime errors.
