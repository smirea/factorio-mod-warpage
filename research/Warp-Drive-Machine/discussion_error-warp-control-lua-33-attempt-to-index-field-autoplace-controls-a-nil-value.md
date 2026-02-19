# Error: warp-control.lua:33: attempt to index field 'autoplace_controls' (a nil value)

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6842df7347d9301e2499c9f4
- Thread ID: 6842df7347d9301e2499c9f4
- Started by: wladekb

---
**wladekb (op):** Warped undergroud, used Soil Analysis, happens when the Soil Analysis process is about to finish:

Notice
The mod Warp Drive Machine (0.9.35) caused a non-recoverable error. Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_nth\_tick(30) **Warp-Drive-Machine**/warp-control.lua:33: attempt to index field 'autoplace\_controls' (a nil value)
stack traceback:
Warp-Drive-Machine\_\_/warp-control.lua:33: in function 'get\_autoplace\_avg\_value'
**Warp-Drive-Machine**/ship-control.lua:1559: in function 'ship\_scan\_ability\_progress'
**Warp-Drive-Machine**/ship-control.lua:650: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:747: in function <**Warp-Drive-Machine**/control.lua:746>

---
**MFerrari (mod author):** please update the mod

---
**wladekb (op):** Updating to 0.9.45 fixed the issues, thanks, it happened I've been at 0.9.35.
