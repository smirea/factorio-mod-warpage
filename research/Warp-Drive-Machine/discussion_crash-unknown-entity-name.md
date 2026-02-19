# Crash, Unknown entity name

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/676882078ada83448740ae90
- Thread ID: 676882078ada83448740ae90
- Started by: sempisan

---
**sempisan (op):** Great Mod! Loving it!
The mod Warp Drive Machine (0.9.17) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
Unknown entity name: wdm\_pirate\_erocket\_8
stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**Warp-Drive-Machine**/control-pirates.lua:269: in function 'PIRATE\_heart\_beat'
**Warp-Drive-Machine**/ship-control.lua:639: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:722: in function <**Warp-Drive-Machine**/control.lua:721>

---
**MFerrari (mod author):** please update the lib mod

---
**sempisan (op):** Sorry, don't know how I missed that.. thanks!
