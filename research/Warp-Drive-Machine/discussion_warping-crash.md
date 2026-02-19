# Warping crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68460b1dc156f2093c7ad6d6
- Thread ID: 68460b1dc156f2093c7ad6d6
- Started by: Svetting

---
**Svetting (op):** Got this when warping to a new planet

The mod Warp Drive Machine (0.9.29) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
An error occured while compiling "decorative:lava-decal-blue:probability" noise expression:
MultioctaveNoise::octaves must be > 0 and can't be infinite
stack traceback:
[C]: in function 'create\_surface'
**Warp-Drive-Machine**/warp-control.lua:516: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:724: in function <**Warp-Drive-Machine**/control.lua:723>

---
**MFerrari (mod author):** update the mod

---
**Svetting (op):** thank you!
