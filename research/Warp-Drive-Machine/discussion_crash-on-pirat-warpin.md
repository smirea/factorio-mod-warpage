# Crash on Pirat warpin

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/674a0a8f42705fa9914f6217
- Thread ID: 674a0a8f42705fa9914f6217
- Started by: basi89

---
**basi89 (op):** Crash when the Ship should apear on the map.

The mod Warp Drive Machine (0.9.7) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(60)
**Warp-Drive-Machine**/control-pirates.lua:113: attempt to index global 'stocks' (a nil value)
stack traceback:
**Warp-Drive-Machine**/control-pirates.lua:113: in function 'pirate\_ship\_arrives'
**Warp-Drive-Machine**/control-pirates.lua:136: in function 'PIRATE\_start\_space\_pirate\_attack'
**Warp-Drive-Machine**/control.lua:841: in function 'check\_timed\_events'
**Warp-Drive-Machine**/control.lua:714: in function <**Warp-Drive-Machine**/control.lua:713>

---
**MFerrari (mod author):** fixed
