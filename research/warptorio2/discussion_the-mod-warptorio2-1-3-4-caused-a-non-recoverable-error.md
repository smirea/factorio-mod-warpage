# The mod Warptorio2 (1.3.4) caused a non-recoverable error.

- URL: https://mods.factorio.com/mod/warptorio2/discussion/600de77e44d7bef892347cc6
- Thread ID: 600de77e44d7bef892347cc6
- Started by: porcupine

---
**porcupine (op):** Happens (repeatedly) on my save, near end game, when trying to warp to a random planet (from being on a frozen riches planet that had been selected during previous warp attempt, if it matters).

Running Warptorio2 with Alien Biomes, Alien Biomes high res terrain, cold biters, even distribution, explosive biters, handyhands automatic handcrafting community update, informatron, planetorio, planetorio expansion planets, and of course warptorio2.

---

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

---
**IronCartographer:** Error while running event warptorio2::on\_tick (ID 0)
Error when running interface function planetorio.FromTemplate: **planetorio**/control\_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
**planetorio**/control\_planets.lua:168: in function 'Generate'
**planetorio**/control\_planets.lua:216: in function <**planetorio**/control\_planets.lua:214>
stack traceback:
[C]: in function 'call'
**warptorio2**/control\_main.lua:940: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:848: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>"

Getting the same in endgame test.

---
**PyroFire (mod author):** My bet is one of the planets is broken.
Have seen this in my own play-throughs, not sure which one.
Seems to happen randomly.

Tick your RNG forward a bit and try warping again, like revealing unexplored chunks.

---
**PyroFire (mod author):** I have added error handling so this is still technically broken, but will instead tell you what the bad template is and warp to uncharted instead of crashing.

---
**PyroFire (mod author):** This is an instance of the missing planet template bug <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>
