# Crash when warping.

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6958350002884a32b0bd3340
- Thread ID: 6958350002884a32b0bd3340
- Started by: siradam7

---
**siradam7 (op):** The mod Warp Drive Machine (1.2.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
LuaSurface API call when LuaSurface was invalid.
stack traceback:
[C]: in function '**newindex'
\_\_Warp-Drive-Machine**/warp-control.lua:887: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:727: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:816: in function <**Warp-Drive-Machine**/control.lua:815>

No other mods than space age
