# Thermite mining

Status: implemented (updated 2026-02-20).

There is no conventional mining in WarpAge in the early game (no burner miners, no electric miners). Mining is done by destructively blasting ore patches to reveal ore item stacks on the ground.

Thermite barrel logo source: `/Users/stefan/Downloads/thermite_barrel.png`; processed and stored as `graphics/icons/thermite-barrel.png` (64px) and `graphics/technology/thermite-barrel.png` (256px).

## Spec checklist

### Items

- [x] Thermite miner item and recipe (`warpage-thermite-miner`) with cost: 1 iron plate, 1 copper plate, 1 calcite
- [x] Item and recipe icon use the thermite barrel
- [x] Throwable consumable starts a `fire-flame` and countdown `3/2/1`, detonates after 3 seconds
- [x] Base blast removes `basic-solid` resources in a 3x3 area (radius 1)
- [x] Ore yield per removed ore type: `floor(max(removed_amount / 100, 50) * productivity_multiplier)` spilled on ground
- [x] Calcite bonus when any ore was removed: `random(1, 5) * productivity_multiplier`
- [x] If no ore removed, shows `x.x`
- [x] Fire burns during countdown and is cleaned up after detonation

### Research

- [x] Mining productivity removed entirely (data stage hide/disable + runtime enforcement/reset)
- [x] `warpage-thermite-mining` trigger research by mining `iron-ore`
- [x] Thermite mining unlock reward: 3 drops of 2 thermite miners; message `psst, look up, check the hub`
- [x] Thermite mining productivity: 5 levels, +1 multiplier per level, costs `100 + 100 * (level - 1)` red science
- [x] Thermite mining radius: 3 levels, +1 radius per level, costs 500 red/green/blue by level
- [x] Productivity and radius tech icons are thermite barrel + top-left overlay (~20% scale)

### Mechanics

- [x] Rescue check every 10 seconds
- [x] Rescue cooldown of 10 minutes between deliveries
- [x] Rescue condition: no calcite and no thermite miners in all player inventories and hub storage
- [x] Rescue delivery: 1 calcite to the hub; message `look, you should never run out of [item=calcite], sending you some how`

## Storage typing

Persistent state is now typed and stored under `storage.warpage.features.thermite_mining`.

- `types/warpage.lua`
  - `WarpageStorageGlobal`
  - `WarpageStorageRoot`
  - `WarpageFeatureStorage`
  - `WarpageThermiteMiningFeatureState`
  - `WarpageThermiteQueuedBlast`

Thermite feature state fields:

- `next_blast_id`
- `pending_blasts`
- `unlock_bonus_delivered`
- `last_calcite_rescue_tick`

## Delivery behavior note

Unlock/rescue deliveries attempt cargo pods first. If pod creation is unavailable, remaining stacks are inserted directly into hub storage (or destroyed hub container when applicable) to preserve guaranteed delivery behavior.
