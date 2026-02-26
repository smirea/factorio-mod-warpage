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

Status: in progress (updated 2026-02-26).

## Spec checklist

- [x] Buildings are restricted to a custom ship tile via prototype `tile_buildability_rules`.
- [x] Ship tile is custom and not mineable.
- [ ] Ship tile visual tint is blue (currently uses base foundation visuals).
- [x] Ship modules are defined in `src/modules/ship/constants.ts` and include an associated blueprint string.
- [ ] Each module is unlocked by separate research (not implemented yet).
- [x] First module is the hub module and is created with startup hub/destroyed-hub setup.
- [x] Hub module tiles are created from blueprint data at runtime, not hardcoded coordinates.
- [x] Connector entity exists as a 2x1 placeable (`warpage-connector`).
- [x] Connector placement is validated to fully fit inside a module and lie on a module edge.
- [x] Invalid connector placement is rejected, refunded, and shows local floating text: "can only be placed on the edge of a module".
- [x] Valid connector placement keeps `warpage-connector` as an entity and stores it in `storage.shipLayout`.
- [x] Connector entity has no collision box, supports 2x1 rotation, and can be built over while remaining mineable via selection box.
- [x] Hub starts with no default connectors.
- [x] Ship layout is stored in `storage.shipLayout`.
- [x] `storage.shipLayout` is initialized during startup and seeded from module defaults.
