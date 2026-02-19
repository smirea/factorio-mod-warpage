# Crash while driving Marvin from Warptorio 2 Expansion through the portal ... on a stream with over 23 players and 200 spectators :(

- URL: https://mods.factorio.com/mod/warptorio2/discussion/603bb8a7aad152085c95fc76
- Thread ID: 603bb8a7aad152085c95fc76
- Started by: IronCartographer

---
**IronCartographer (op):** The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_player\_changed\_position (ID 83)
The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_entity\_cloned (ID 120)
**warptorio2**/control\_main.lua:829: attempt to get length of local 'inv' (a nil value)
stack traceback:
**warptorio2**/control\_main.lua:829: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
[C]: in function 'clone'
**warptorio2**/control\_main.lua:387: in function 'TeleportLogic'
**warptorio2**/control\_main.lua:428: in function 'tx'
**warptorio2**/lib/lib\_control\_cache.lua:161: in function 'call\_player'
**warptorio2**/lib/lib\_control\_cache.lua:538: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
stack traceback:
[C]: in function 'clone'
**warptorio2**/control\_main.lua:387: in function 'TeleportLogic'
**warptorio2**/control\_main.lua:428: in function 'tx'
**warptorio2**/lib/lib\_control\_cache.lua:161: in function 'call\_player'
**warptorio2**/lib/lib\_control\_cache.lua:538: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>

---
**IronCartographer (op):** This one happened on warp, just folding it in here to avoid spamming:

The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_entity\_cloned (ID 120)
**warptorio2**/control\_main.lua:829: attempt to get length of local 'inv' (a nil value)
stack traceback:
**warptorio2**/control\_main.lua:829: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
[C]: in function 'clone\_entities'
**warptorio2**/control\_main.lua:986: in function 'Warp'
**warptorio2**/control\_main.lua:859: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>
stack traceback:
[C]: in function 'clone\_entities'
**warptorio2**/control\_main.lua:986: in function 'Warp'
**warptorio2**/control\_main.lua:859: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**Phoenix27833:** The issue is a player left the game while in the waiting to respawn screen
His controller type is defines.controllers.ghost and in this state he does not have an inventory
Code needs to check if get\_main\_inventory() returns nil and act accordingly

---
**IronCartographer (op):** If we know the player, we could try removing their data from the game using <https://lua-api.factorio.com/latest/LuaGameScript.html#LuaGameScript.purge_player>

This is for the second issue, not the first, to be clear.

---
**IronCartographer (op):** Further update: Issue occurs if player is dead when a vehicle goes through an elevator as well.

---
**PyroFire (mod author):** rip.

Add me on steam for future if stuff like this comes up.

> The issue is a player left the game while in the waiting to respawn screen
> His controller type is defines.controllers.ghost and in this state he does not have an inventory
> Code needs to check if get\_main\_inventory() returns nil and act accordingly

Thank you for solution.
