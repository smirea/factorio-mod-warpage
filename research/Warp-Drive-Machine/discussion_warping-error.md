# Warping error

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/674582275c46b21db4d9f4aa
- Thread ID: 674582275c46b21db4d9f4aa
- Started by: ak86

---
**ak86 (op):** Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/control-space-station.lua:122: bad argument #1 of 1 to 'random' (interval is empty)
stack traceback:
[C]: in function 'random'
**Warp-Drive-Machine**/control-space-station.lua:122: in function 'SPACE\_STATION\_arrive'
**Warp-Drive-Machine**/warp-control.lua:827: in function 'post\_warp\_routines'
**Warp-Drive-Machine**/warp-control.lua:747: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:555: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:720: in function <**Warp-Drive-Machine**/control.lua:719>

---
**MFerrari (mod author):** fixed

---
**ak86 (op):** <3
