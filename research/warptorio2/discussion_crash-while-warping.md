# Crash while warping

- URL: https://mods.factorio.com/mod/warptorio2/discussion/608200bbef2927446603b8f7
- Thread ID: 608200bbef2927446603b8f7
- Started by: thuejk

---
**thuejk (op):** I get the following crash when I set the warp target to (random), from some other target. The crash occurs the moment I warp.

The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
Error when running interface function planetorio.FromTemplate: **planetorio**/control\_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
**planetorio**/control\_planets.lua:168: in function 'Generate'
**planetorio**/control\_planets.lua:216: in function <**planetorio**/control\_planets.lua:214>
stack traceback:
[C]: in function 'call'
**warptorio2**/control\_main.lua:940: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:848: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** added to list of flaws planetorio section.

Workaround is to tick RNG forward a bit like exploration and pollution spread so you get working data.

---
**PyroFire (mod author):** This is an instance of the missing planet template bug <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>
