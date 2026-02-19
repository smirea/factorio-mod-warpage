# Attempt to warp to Nauvis caused a non-recoverable error

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6172d750d316fc71e8948d19
- Thread ID: 6172d750d316fc71e8948d19
- Started by: Warmgray1

---
**Warmgray1 (op):** I have basically reserched everything and want to sattledown on Nauvis.
And when I finally wrapped to Nauvis I got a notice showing:

The mod Warptorio2 Expansion (1.1.69) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2\_expansion::Custom event (ID 210)
**warptorio2\_expansion**/control.lua:50: table index is nil
stack traceback:
**warptorio2\_expansion**/control.lua:50: in function 'update\_planet\_info'
**warptorio2\_expansion**/control.lua:101: in function 'on\_warptorio\_warp'
**warptorio2\_expansion**/control.lua:379: in function <**warptorio2\_expansion**/control.lua:378>
stack traceback:
[C]: in function 'raise\_event'
**warptorio2**/lib/lib\_control.lua:258: in function 'vraise'
**warptorio2**/control\_main.lua:872: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** This is related to the planet template bug: <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>
