# Crash when creating a surface

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68a576054f96c17a285db14b
- Thread ID: 68a576054f96c17a285db14b
- Started by: raley

---
**raley (op):** I ran into this error while playing a heavily modded game. There are a few planet mods which I'm guessing caused an issue.

The mod Warp Drive Machine (1.0.8) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:741: bad argument #1 of 3 to 'create\_surface' (string expected, got nil)
stack traceback:
[C]: in function 'create\_surface'
**Warp-Drive-Machine**/warp-control.lua:741: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:647: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:772: in function <**Warp-Drive-Machine**/control.lua:771>

This fixed the issue for my game, but it was done by an AI and I didn't check the work, so no idea if it's addressing the core problem. The next two surfaces seemed fine:

```
       677                map_gen.starting_points = map_gen.starting_points or {{x=0, y=0}}
       678                storage.persistent_planets[surface_name] = planet_number
       679                map_gen.persistent_surface_name = surface_name
       680 +              else
       681 +              -- nauvis-based discovered planet needs a surface name
       682 +              surface_name = "planet_"..planet_number.."_"..force.name
       683 +              storage.persistent_planets[surface_name] = planet_number
       684 +              map_gen.persistent_surface_name = surface_name
       685                end
       686              end --discover_planet
       687
```

Really enjoying your mod!

---
**MFerrari (mod author):** working on a new version, thks
