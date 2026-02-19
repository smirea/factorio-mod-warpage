# Crash

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/68d0dc14362159ea25b0f7c5
- Thread ID: 68d0dc14362159ea25b0f7c5
- Started by: johnru

---
**johnru (op):** Good afternoon. I get this error and then I'm thrown out.

---
**johnru (op):** Mod Warptorio 2.0 (Space Age) (0.2.9) caused an unrecoverable error.
Please report this error to the mod's author.

Error while running event warptorio-space-age::on\_tick (ID 0)
LuaSpacePlatform::space\_location is read only.
stack traceback:
[C]: in function '**newindex'
\_\_warptorio-space-age**/control.lua:1328: in function 'next\_warp\_zone\_space'
**warptorio-space-age**/control.lua:1401: in function 'next\_warp\_zone'
**warptorio-space-age**/control.lua:1603: in function <**warptorio-space-age**/control.lua:1549>

---
**Venca123 (mod author):** You are on old version of factorio. Update to the latest and this will be fixed. If I remember correctly this was fixed in 2.0.68
