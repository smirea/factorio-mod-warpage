# Mod sometimes crashes when warping on 2.0.49

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6822506fa1d8e50c791dafad
- Thread ID: 6822506fa1d8e50c791dafad
- Started by: zenek_tm

---
**zenek_tm (op):** The mod crashes on 2.0.49 with error:
The mod Warp Drive Machine (0.9.33) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
MultioctaveNoise::octaves must be > 0 and can't be infinity
stack traceback:
[C]: in function 'create\_surface'
**Warp-Drive-Machine**/warp-control.lua:516: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:726: in function <**Warp-Drive-Machine**/control.lua:725>

I warped several times on this version, but now it always crashes when warp countdown goes to 0.

---
**MFerrari (mod author):** can you please share your saved game ?

---
**zenek_tm (op):** I uploaded the save file to discord.

---
**MFerrari (mod author):** please try the new version
