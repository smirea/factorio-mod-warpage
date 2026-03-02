The ship is a set of modules connected by small doorways or hallways. All modules have a special flooring (space-platform-foundation) tile and can have different shapes. With research you can obtain new module shapes, larger doorways and hallways

The center of the ship is always "The Hub" (see below)

At every warp, the ship is always placed centered at 0,0 and all its configuration is moved over from the previous warp. the player is also moved over from where they were. The ship will move with the player across many surfaces

# The Hub

The Hub is the center of the ship, it's invincible and not mineable and it's a custom compound entity, the main entity being a `cargo-landing-pad`. The hub will get more features, upgrades and functionality with research. The hub also has its own accumulator, electrical grid and power supply area but no electrical wire connection (still has circuit wire connectors). The hub also has roboport built in it that uses the robots in its inventory and provides vision like a radar

Hub entities currently used:

- Main: `cargo-landing-pad`
- Hidden centered power pole: `warpage-hub-power-pole`
- Hidden centered accumulator: `warpage-hub-accumulator`
- Hidden centered roboport: `warpage-hub-roboport`
- Fluid tank pipes (bottom-left and bottom-right): `warpage-hub-fluid-pipe`
- Destroyed-hub repair container: `warpage-destroyed-hub-container`
- Destroyed-hub rubble visual: `warpage-destroyed-hub-rubble`

Note: at the very beginning of the game, the hub starts off destroyed and the first task is to rebuild it.

When opening The Hub, there is a custom GUI anchored to the top right of the inventory screen that shows various Hub metrics:

- accumulator charge as [icon] [progress bar] [amount / total] table
- how much of each fluid as [icon] [progress bar] [amount / total] table

## Destroyed Hub

It's a big storage chest with filtered slots for all the requirements needed to rebuild - uses the rubble version of a destroyed cargo landing pad as a visual. There is a floating message box above it detailing the remaining items needed for repair and it updates as items are added. Once all items are in, remove the rubble and repair items, place The Hub, and transfer any extra stored items into the rebuilt hub inventories

Repair cost: 200 stone, 200 coal, 100 copper ore, 100 iron plate, 10 calcite

## Hub Upgrades

- water pipes - each water pipe is its own container - send a signal on the green wire for each fluid value on the main hub circuit network
- water container storage size
- power supply range
- accumulator size

# Ship Building

Status: implemented baseline (updated 2026-03-02).

## Current specification

- Buildings are restricted to a custom ship tile via prototype `tile_buildability_rules`.
- Ship tile is custom and not mineable.
- Ship modules are defined in `src/modules/ship/constants.ts` and each contains a blueprint string.
- Hub is the initial placed module and is created through startup hub/destroyed-hub flow.
- Module unlock state is research-driven and synced into runtime module state.
- Module management UI is a top-left roster (`warpage.module-roster-*`).
- Hub is fixed in place and is not shown in the movable module roster.
- Each module definition has one persistent instance in `storage.shipModules` (no inventory module items).
- Placement uses temporary hidden carrier item/entity for native rotate/place controls.
- Module button click toggles placement on/off for that module.
- Any placement cancellation path cleans cursor carrier item state (no leaked items).
- Placement ghost uses generated full blueprint footprint preview per rotation (not 1x1 icon ghost).
- Placing an unplaced module stamps rotated module tiles and any default module connectors.
- Placing an already placed module performs a move transaction.
- Translation moves preserve entity state through area clone where possible.
- Rotation moves are strict and abort if preservation cannot be guaranteed.
- Move finalization clears source area entities and ship tiles before commit completes.
- Connector ownership and orientation/side are stored in `storage.shipConnectors`.
- Bridge state is rebuilt deterministically into `storage.shipBridges`.
- Active placement sessions and render ids are stored in `storage.shipPlacementByPlayer`.

## Connector perimeter rule

- A connector must fully fit inside module tiles as a 2x1 footprint.
- A connector is valid only when its open side touches outside-reachable empty space.
- Outside-reachable means reachable by flood-fill from outside the module bounding box.
- This includes concave interiors that are open to exterior space (example: U-shaped module interior opening).
- Closed internal cavities are not valid connector targets.
- Placement highlights all perimeter candidate connector positions.
- During module placement, nearby connector links are previewed as bridge visuals.
- Bridge preview/evaluation can target valid perimeter candidates on other modules even if the placed module has no connector entity yet.
- Connector entity visuals use hazard-concrete terrain sprites so placed connectors read like hazard concrete placement, not inventory icons.

## Build-time generated artifacts

- Build script computes module geometry as the first step before TSTL.
- Build script decodes module blueprints and precomputes all rotations.
- Build output includes normalized tiles per rotation.
- Build output includes per-rotation bounds.
- Build output includes all outside-reachable perimeter connector candidates.
- Build output includes rotated default connectors.
- Build script writes [src/modules/ship/generated.ts](/Users/stefan/code/factorio-mod-warpage/src/modules/ship/generated.ts).
- `generated.ts` exports `shipGeneratedGeometry`.
- `generated.ts` exports `shipGeneratedIcons`.
- Runtime uses generated geometry and does not decode blueprint geometry on load.
- Module icon PNGs and placement previews are generated to `src/modules/ship/graphics/`.
- Data stage sprite/item/entity icon paths are sourced from `shipGeneratedIcons`.
- Module shape image is used as the module technology icon.

## Known deferred

- Ship tile visual tinting is still using base foundation visuals.
- Naming/tinting per module instance is not implemented yet.
