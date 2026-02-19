# Random crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/682806b0b9f0cbede79df84c
- Thread ID: 682806b0b9f0cbede79df84c
- Started by: Faenyx

---
**Faenyx (op):** One player was dismantiling stuff. We were on a cave planet

The mod Warp Drive Machine (0.9.35) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:33: attempt to index field 'autoplace\_controls' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:33: in function 'get\_autoplace\_avg\_value'
**Warp-Drive-Machine**/ship-control.lua:1559: in function 'ship\_scan\_ability\_progress'
**Warp-Drive-Machine**/ship-control.lua:650: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:747: in function <**Warp-Drive-Machine**/control.lua:746>

Error did not re-occur on reload so not sure what happened.

---
**MFerrari (mod author):** fixed

---
**Faenyx (op):** Wow, that was fast! Been loving the mod so far!
