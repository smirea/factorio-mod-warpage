# Crash when trying to warp

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5edb8ffe472fe4000d53b631
- Thread ID: 5edb8ffe472fe4000d53b631
- Started by: ichvii

---
**ichvii (op):** The mod Warptorio2 (1.2.8) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
Error when running interface function planetorio.FromTemplate: **planetorio**/control\_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
**planetorio**/control\_planets.lua:168: in function 'Generate'
**planetorio**/control\_planets.lua:216: in function <**planetorio**/control\_planets.lua:214>
stack traceback:
**warptorio2**/control\_main.lua:896: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:804: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:280: in function <**warptorio2**/lib/lib\_control.lua:280>
stack traceback:
[C]: in function 'call'
**warptorio2**/control\_main.lua:896: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:804: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:280: in function <**warptorio2**/lib/lib\_control.lua:280>

Supposed to be labeld bug. Is persistent with the last save. I was on planet 157 I think.

---
**PyroFire (mod author):** This is an instance of the missing template bug <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>
