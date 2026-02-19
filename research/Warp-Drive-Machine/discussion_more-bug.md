# more bug

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6745b6192e7fe746e850342c
- Thread ID: 6745b6192e7fe746e850342c
- Started by: ak86

---
**ak86 (op):** 394.256 Error MainLoop.cpp:1432: Exception at tick 367519: The mod Warp Drive Machine (0.9.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_chunk\_generated (ID 12)
**Warp-Drive-Machine**/control.lua:1924: bad argument #1 of 1 to 'random' (interval is empty)
stack traceback:
[C]: in function 'random'
**Warp-Drive-Machine**/control.lua:1924: in function 'add\_random\_ores\_on\_chest'
**Warp-Drive-Machine**/control.lua:1848: in function <**Warp-Drive-Machine**/control.lua:1778>

---
**MFerrari (mod author):** any mod you playing that removes ores ?

---
**ak86 (op):** hm... i dont think so, i've removed textplates, since it was clogging station trade

idk if there is better mod list anywhere
1.353 Loading mod settings vehicle-corpses 0.1.1 (settings.lua)
1.353 Loading mod settings ZombieHordeFaction 0.2.0 (settings.lua)
1.353 Loading mod settings aai-vehicles-miner 0.7.1 (settings.lua)
1.354 Loading mod settings Arachnids\_enemy 1.2.0 (settings.lua)
1.354 Loading mod settings ballistic\_missile 0.1.16 (settings.lua)
1.354 Loading mod settings blueprint\_reader 2.0.2 (settings.lua)
1.355 Loading mod settings DiscoScience 2.0.1 (settings.lua)
1.355 Loading mod settings dqol-resource-monitor 1.2.6 (settings.lua)
1.356 Loading mod settings Evolution Reduction 2.0.0 (settings.lua)
1.356 Loading mod settings FasterStart 2.0.1 (settings.lua)
1.356 Loading mod settings floating-damage-text 20.0.0 (settings.lua)
1.357 Loading mod settings GhostWarnings 1.3.2 (settings.lua)
1.357 Loading mod settings Gun\_Turret\_Alerts 2.0.7 (settings.lua)
1.357 Loading mod settings HelicopterRevival 0.3.0 (settings.lua)
1.358 Loading mod settings Hovercrafts 2.0.3 (settings.lua)
1.359 Loading mod settings informatron 0.4.0 (settings.lua)
1.359 Loading mod settings inventory-repair 20.0.2 (settings.lua)
1.359 Loading mod settings jetpack 0.4.6 (settings.lua)
1.360 Loading mod settings k2-wind-turbine 0.0.4 (settings.lua)
1.360 Loading mod settings KS\_Combat\_Updated 1.2.3 (settings.lua)
1.361 Loading mod settings Kux-CoreLib 3.14.4 (settings.lua)
1.364 Loading mod settings laser\_rifle 2.0.3 (settings.lua)
1.365 Loading mod settings Peppermint\_Mining 2.3.2 (settings.lua)
1.365 Loading mod settings Portals-chaosfork 0.7.2 (settings.lua)
1.366 Loading mod settings Repair\_Turret 2.0.2 (settings.lua)
1.367 Loading mod settings Reusable\_Robots 2.0.0 (settings.lua)
1.367 Loading mod settings show-max-underground-distance 0.1.0 (settings.lua)
1.368 Loading mod settings SpidertronEnhancements 1.10.4 (settings.lua)
1.368 Loading mod settings tiered-gas-generator 1.1.5 (settings.lua)
1.369 Loading mod settings transport-ring-teleporter 0.1.6 (settings.lua)
1.369 Loading mod settings Automatic\_Train\_Painter 2.0.1 (settings.lua)
1.370 Loading mod settings BottleneckLite 1.3.2 (settings.lua)
1.370 Loading mod settings CharacterModHelper 2.0.0 (settings.lua)
1.371 Loading mod settings Kux-OrbitalIonCannon 3.6.0 (settings.lua)
1.373 Loading mod settings aai-loaders 0.2.5 (settings.lua)
1.373 Loading mod settings alien-biomes 0.7.2 (settings.lua)
1.374 Loading mod settings kry-spidertron 2.0.1 (settings.lua)
1.375 Loading mod settings SpaceAgeUnnerfed 1.0.0 (settings.lua)
1.376 Loading mod settings SpidertronPatrols 2.5.3 (settings.lua)
1.376 Loading mod settings Cold\_biters 2.0.7 (settings.lua)
1.377 Loading mod settings Warp-Drive-Machine 0.9.5 (settings.lua)
1.378 Loading mod settings MechanicusMiniMAX 0.1.7 (settings-updates.lua)
1.379 Loading mod settings Cold\_biters 2.0.7 (settings-updates.lua)
1.380 Loading mod settings Warp-Drive-Machine 0.9.5 (settings-updates.lua)
1.380 Loading mod settings vehicle-corpses 0.1.1 (settings-final-fixes.lua)
1.381 Loading mod settings Kux-CoreLib 3.14.4 (settings-final-fixes.lua)
1.389 Loading mod core 0.0.0 (data.lua)
1.422 Loading mod base 2.0.21 (data.lua)
1.713 Loading mod ZombieHordeFaction 0.2.0 (data.lua)
1.733 Loading mod aai-vehicles-miner 0.7.1 (data.lua)
1.745 Loading mod aai-vehicles-warden 0.6.4 (data.lua)
1.758 Loading mod Arachnids\_enemy 1.2.0 (data.lua)
1.784 Loading mod ballistic\_missile 0.1.16 (data.lua)
1.797 Loading mod blueprint\_reader 2.0.2 (data.lua)
1.808 Loading mod bullet-trails 0.7.1 (data.lua)
1.819 Loading mod DiscoScience 2.0.1 (data.lua)
1.830 Loading mod dqol-resource-monitor 1.2.6 (data.lua)
1.841 Loading mod EditMapSettings 0.1.5 (data.lua)
1.851 Loading mod elevated-rails 2.0.21 (data.lua)
1.890 Loading mod factorio-crash-site 2.0.2 (data.lua)
1.906 Loading mod FasterStart 2.0.1 (data.lua)
1.918 Loading mod flib 0.15.0 (data.lua)
1.931 Loading mod FluidWagonColorMask 2.0.0 (data.lua)
1.943 Loading mod GhostWarnings 1.3.2 (data.lua)
1.954 Loading mod grappling-gun 0.4.1 (data.lua)
1.967 Loading mod Gun\_Turret\_Alerts 2.0.7 (data.lua)
1.978 Loading mod HelicopterRevival 0.3.0 (data.lua)
1.994 Loading mod Hovercrafts 2.0.3 (data.lua)
1.995 Script @**Hovercrafts**/prototypes/equipment.lua:6: grid-hovercraft = 4x6 4, 6
1.995 Script @**Hovercrafts**/prototypes/equipment.lua:30: grid-missile-hovercraft = 6x6 6, 6
2.014 Loading mod informatron 0.4.0 (data.lua)
2.027 Loading mod jetpack 0.4.6 (data.lua)
2.041 Loading mod k2-wind-turbine 0.0.4 (data.lua)
2.053 Loading mod Kux-CoreLib 3.14.4 (data.lua)
2.064 Loading mod laser\_rifle 2.0.3 (data.lua)
2.075 Loading mod mferrari\_lib 0.2.0 (data.lua)
2.093 Loading mod Peppermint\_Mining 2.3.2 (data.lua)
2.104 Loading mod Portals-chaosfork 0.7.2 (data.lua)
2.115 Loading mod quality 2.0.21 (data.lua)
2.134 Loading mod radar-equipment 0.1.4 (data.lua)
2.146 Loading mod Repair\_Turret 2.0.2 (data.lua)
2.162 Loading mod Reusable\_Robots 2.0.0 (data.lua)
2.174 Loading mod shield-projector 0.2.2 (data.lua)
2.189 Loading mod SpidertronEnhancements 1.10.4 (data.lua)
2.201 Loading mod Teleporters 2.0.0 (data.lua)
2.217 Loading mod tiered-gas-generator 1.1.5 (data.lua)
2.235 Loading mod transport-ring-teleporter 0.1.6 (data.lua)
2.247 Loading mod atan-crash-site 2.0.2 (data.lua)
2.260 Loading mod Automatic\_Train\_Painter 2.0.1 (data.lua)
2.272 Loading mod CharacterModHelper 2.0.0 (data.lua)

---
**ak86 (op):** seems to be conflict with <https://mods.factorio.com/mod/Cursed-FMD>

---
**MFerrari (mod author):** The mod was trying to add resources to a loot chest, and the resource does not exist in your game... so some other mod removed that item.
I'm adding an "if" on the line that crashed, it wont crash on that line, but will also not add loot... other crashes may happen elsewhere...
