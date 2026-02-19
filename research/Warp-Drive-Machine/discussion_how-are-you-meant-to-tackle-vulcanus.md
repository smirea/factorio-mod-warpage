# How are you meant to tackle Vulcanus?

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68c5b6e831ac594d98265db5
- Thread ID: 68c5b6e831ac594d98265db5
- Started by: Zeritor

---
**Zeritor (op):** As in this mod you land on a surface at a random position, the warp base lands far in to Big Demolisher territory for us, where we aggro a Big Demolisher due to construction inside his territory. We can't even scratch it and that's with maxed out research at the current stage of the game. We have cleared our entire top layer bar defenses by moving everything downstairs - and even a combination of all turrets we've got/looted so far, an insane amount of Uranium Gun Turrets as well as Teslas, etc... The Big Demolisher regens faster than we can hurt it. Poison and even the frost weapons do nothing, a legendary tank full of uranium shells does nothing.

I enabled Console Commands and teleported myself, I can see that (0, 0) still has the Space Age protection where no Demolisher territory is present - are we meant to land there?

I think in standard Space Age you can't even tackle Big Demolishers without the Railgun and a ton of Damage+ Research, as they regen at 24,000 HP/s. I can see there is a Warp Drive Machien override for it that only has 0.6 HP/s regen - but that only appears on Demolisher modified planets - are they meant to be the low regen versions?

We even deleted the surface to see if it would regen/reposition us, but seems Vulcanus (and assuming other Space Age planets) is generated from the Game Seed (unlike random surfaces), so we just get the exact same result.

Edit: Also, we have tried every ship power, they all do nothing to Big Demolishers.

---
**Zeritor (op):** Currently working around it with the console command: `/c game.player.force.set_spawn_position({0, 0}, 'vulcanus')`

Modifies the player spawn position on Vulcanus to be at the origin, putting you in the safe zone. Seems ship landing coordinates are based off player spawn.

Unsure if this will have affected other planets. Also unsure if your Vulcanus surface already needs to exist - ours did as we landed thiere the first time and accelerated warped away before the worm got to us. Next time we visted Vulcanus after running that console command, we landed in the safe zone.

---
**MFerrari (mod author):** The ship should spawn on safe zone. Whats the mod pack and version ?

---
**Zeritor (op):** We just pulled mods together ourselves. Using Warp Drive machine and all the dependencies, plus a few non-cheaty QoL mods we usually use.

Full list:

```
base
elevated-rails
quality
space-age
alien-biomes: 0.7.4
alien-biomes-graphics: 0.7.1
Arachnids_enemy: 1.2.0
ArmouredBiters: 1.2.1
better-victory-screen: 1.0.0
blueprint-sandboxes: 3.1.0
BottleneckLite: 1.3.4
CharacterModHelper: 2.0.4
CircuitHUD-V2: 2.5.1
Cold_biters: 2.1.0
CopyPasteModules: 0.2.0
EvenDistributionLite: 1.4.2
Explosive_biters: 2.3.1
factorio-crash-site: 2.0.4
factoryplanner: 2.0.33
FactorySearch: 1.14.0
flib: 0.16.2
inventory-repair: 20.0.3
MechanicusMiniMAX: 0.1.8
mferrari_graphics_pack_1: 0.0.1
mferrari_lib: 0.5.4
Pi-C_lib: 2.0.2
teleporting_machine: 0.0.4
toolbars-mod: 2.38.2
Toxic_biters: 2.0.4
turret-activation-delay: 0.1.2
VehicleSnap: 2.0.2
Warp-Drive-Machine: 1.0.11
ZombieHordeFaction: 0.2.1
```

So it's odd that we're not spawning at (0, 0) then? Unless we modified something by accident. The server we're using was awkward to set up. We just assumed landing on a surface was a random position each time. Seems setting the spawn manually with that command will fix it for us going forwards - but unsure how it happened.
