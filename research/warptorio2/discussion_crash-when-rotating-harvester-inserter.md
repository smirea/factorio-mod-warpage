# Crash when rotating harvester inserter

- URL: https://mods.factorio.com/mod/warptorio2/discussion/64316e49d435a190fa1c897a
- Thread ID: 64316e49d435a190fa1c897a
- Started by: michal_plxD

---
**michal_plxD (op):** The mod Warptorio2 (1.3.1) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_player\_rotated\_entity (ID 21)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/control\_class\_teleporter.lua:280: in function 'RemakeChestPair'
**warptorio2**/control\_class\_teleporter.lua:286: in function 'SwapLoaderChests'
**warptorio2**/control\_main\_helpers.lua:592: in function '?'
**warptorio2**/lib/lib\_control\_cache.lua:152: in function 'call\_ents'
**warptorio2**/lib/lib\_control\_cache.lua:400: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
