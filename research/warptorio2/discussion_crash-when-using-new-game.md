# Crash when using New Game+

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5f4572f3225d6f290cedb099
- Thread ID: 5f4572f3225d6f290cedb099
- Started by: Austin5003

---
**Austin5003 (op):** The mod said there was an optional compatibility with New Game+, was it really an incompatibility that was improperly labelled?
Error while running event warptorio2::on\_tick (ID 0)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
**warptorio2**/lib/lib\_control.lua:95: in function 'AutoBalanceHeat'
**warptorio2**/control\_main\_helpers.lua:816: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/lib/lib\_control.lua:95: in function 'AutoBalanceHeat'
**warptorio2**/control\_main\_helpers.lua:816: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** It's meant to be compatible.
Thanks for report.

---
**PyroFire (mod author):** Added to list of flaws.
