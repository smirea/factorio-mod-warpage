# Start feature

Status: partially implemented (updated 2026-02-25).

The start feature replaces vanilla freeplay onboarding so each run begins directly in Warp Age flow.

## Spec checklist

### Freeplay setup

- [x] Vanilla crashsite and intro are fully skipped.
- [x] Vanilla crashsite ship/debris startup grants are disabled.
- [x] Forbidden starter items are removed from freeplay created/respawn grants: `pistol`, `submachine-gun`, `firearm-magazine`, `piercing-rounds-magazine`, `uranium-rounds-magazine`, `burner-mining-drill`, `electric-mining-drill`, `stone-furnace`, `iron-plate`, `wood`, `small-electric-pole`.
- [x] Startup freeplay settings are applied during init and configuration changes.

### Player setup

- [x] Force spawn is set near the ship entrance.
- [x] Players are placed at a non-colliding position near the ship entrance.
- [x] Forbidden starter items are stripped from player inventories (`character_main`, `character_guns`, `character_ammo`, `character_trash`).

### Startup supplies

- [ ] Spawn one startup chest in front of the destroyed hub.
- [ ] Put the starting kit in that chest: `2x` legendary `steel-furnace`, `50x` `jellynut`.
- [ ] Do not grant startup kit items directly to individual players.

### Ship handoff

- [x] Initial hub anchor is fixed at map center (`0,0`).
- [x] Startup transitions directly into the ship/hub lifecycle flow.
