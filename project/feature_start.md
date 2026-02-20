# Start Feature

Status: implemented

## Behavior

1. Skip the vanilla crash site entirely.
   - `freeplay.set_disable_crashsite(true)`
   - `freeplay.set_skip_intro(true)`
   - `freeplay.set_ship_items({})`
   - `freeplay.set_debris_items({})`

2. Remove forbidden starter items from freeplay grants and player inventories.
   - `pistol`
   - `submachine-gun`
   - `firearm-magazine`
   - `piercing-rounds-magazine`
   - `uranium-rounds-magazine`
   - `burner-mining-drill`
   - `electric-mining-drill`
   - `stone-furnace`
   - `iron-plate`
   - `wood`
   - `small-electric-pole`

3. Keep initial ship/hub centered at `0,0`.
   - Uses `ShipConstants.hub_position = { x = 0, y = 0 }`
   - Ship setup remains owned by `modules/ship/control.lua`

4. Place players at the ship entrance.
   - Uses `ShipConstants.ship_entrance_position = { x = 0, y = 5 }`
   - Sets force spawn position and teleports players to a non-colliding position near this point

5. Add starting items once per player.
   - `2x` legendary `steel-furnace`
   - `50x` `jellynut`
   - Tracked in `storage.warpage.features.startup.configured_player_indices`

## Architecture

- Entry module: `modules/startup.lua`
- Loader registration: `core/feature_loader.lua` registers `modules.startup` as the control runner
- Startup module performs start checks/setup, then calls ship setup runner (`modules.ship.control`)
