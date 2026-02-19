# Unrecoverable error

- URL: https://mods.factorio.com/mod/warptorio/discussion/5ce5f47b1edd28000d395471
- Thread ID: 5ce5f47b1edd28000d395471
- Started by: Ferlonas

---
**Ferlonas (op):** It seems to be related to the teleporter. I reloaded an autosave and mined the mobile teleporter, then the error did not occur anymore.

MainLoop.cpp:1183: Exception at tick 3219375: The mod Warptorio caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio::on\_tick (ID 0)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
**warptorio**/control.lua:616: in function 'transfert\_energy\_use'
**warptorio**/control.lua:521: in function 'transfert\_resources'
**warptorio**/control.lua:556: in function 'entrance\_transfert\_resources'
**warptorio**/control.lua:569: in function 'logistic\_update'
**warptorio**/control.lua:307: in function <**warptorio**/control.lua:304>
stack traceback:
[C]: in function '**index'
\_\_warptorio**/control.lua:616: in function 'transfert\_energy\_use'
**warptorio**/control.lua:521: in function 'transfert\_resources'
**warptorio**/control.lua:556: in function 'entrance\_transfert\_resources'
**warptorio**/control.lua:569: in function 'logistic\_update'
**warptorio**/control.lua:307: in function <**warptorio**/control.lua:304

---
**NONOCE (mod author):** It is related to the teleporter yes. There must be some cases the mod is not handling well, it's either from warping or upgrading the logistic, I will try to find out.
