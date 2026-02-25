# Thermite mining

Status: implemented (updated 2026-02-25).

There is no conventional mining in WarpAge in the early game (no burner miners, no electric miners). Mining is done by destructively blasting ore patches to reveal ore item stacks on the ground.

## Spec checklist

### Items

- [x] Thermite miner item and recipe (`warpage-thermite-miner`) with cost: 1 iron plate, 1 copper plate, 1 calcite
- [x] Item and recipe icon use the thermite barrel
- [x] Throwable consumable starts a `fire-flame` and countdown `3/2/1`, detonates after 3 seconds
- [x] Countdown and empty-blast `x.x` tooltip are shown to players
- [x] Base blast removes `basic-solid` resources in a 4x4 area (radius 2)
- [x] Ore yield per removed ore type: `ceil(max(5, min(removed_amount / 100, 25)) * productivity_multiplier * ore_multiplier)` spilled on ground
- [x] Ore and calcite drops are placed at the center of the removed area
- [x] Ore multipliers are configurable in runtime: iron/copper `1x`, coal `0.75x`, stone `0.5x`, calcite `0.4x`, tungsten `0.2x`, scrap `1x`, fallback `0.5x`
- [x] Ore drops are split into stacks of `500` when total yield exceeds 500
- [x] Calcite bonus always drops first on detonation (including empty ground): `random(1, 5) * productivity_multiplier`
- [x] If no ore removed, shows `x.x`
- [x] Fire burns during countdown and is cleaned up after detonation

### Research

- [x] Mining productivity removed entirely
- [x] `warpage-thermite-mining` trigger research by mining `iron-ore`
- [x] Thermite mining unlock reward: 3 drops of 2 thermite miners; message `psst, look up, check the hub`
- [x] Thermite mining productivity: 5 levels, +1 multiplier per level, costs `100 + 100 * (level - 1)` red science
- [x] Thermite mining radius: 3 levels, +1 radius per level, costs 500 red/green/blue by level
- [x] Productivity and radius tech icons are thermite barrel + top-left overlay (~20% scale)

### Mechanics

- [x] Rescue check every 10 seconds
- [x] Rescue cooldown is 10 minutes between deliveries only when hub is rebuilt (main hub present)
- [x] Rescue condition: no calcite and no thermite miners in all player inventories and hub storage
- [x] During hub repair phase, emergency support targets a player position (cargo pod on player) instead of hub storage
- [x] Repair-phase emergency support only starts after `warpage-thermite-mining` research is complete and a 2-minute grace period has elapsed
- [x] Rescue delivery: 1 calcite (`hub` when rebuilt, `player-targeted cargo pod` during repair phase after grace); message `look, you should never run out of [item=calcite], sending you some now`
