# Start Feature

Status: implemented

## Behavior

1. Skip the vanilla crash site entirely.
   - Start directly in Warp Age flow without vanilla crashsite/tutorial setup.

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
   - The initial hub anchor point is fixed at map center.

4. Place players at the ship entrance.
   - Spawn/teleport players near the hub entrance in a non-colliding position.

5. Add starting items once per player.
   - `2x` legendary `steel-furnace`
   - `50x` `jellynut`
