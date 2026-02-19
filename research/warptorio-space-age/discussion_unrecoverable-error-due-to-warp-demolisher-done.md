# unrecoverable error due to warp demolisher [Done]

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/67c4be1e5c4ad983d3683aa4
- Thread ID: 67c4be1e5c4ad983d3683aa4
- Started by: SoSquared

---
**SoSquared (op):** This error occurs when the warp timer reaches 12:50 on a regular planet without any other mods

The mod Warptorio 2.0 (Space Age) (0.0.11) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_tick (ID 0)
member: Entity "warp-demolisher" is not Commandable
stack traceback:
[C]: in function 'add\_member'
**warptorio-space-age**/control.lua:413: in function 'create\_angry\_biters'
**warptorio-space-age**/control.lua:629: in function 'check\_wave'
**warptorio-space-age**/control.lua:921: in function <**warptorio-space-age**/control.lua:880>

---
**Venca123 (mod author):** Fixed
