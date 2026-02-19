# Crash on warp

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6127699ff8407ea741d4150f
- Thread ID: 6127699ff8407ea741d4150f
- Started by: Ferlonas

---
**Ferlonas (op):** 8615.760 Error MainLoop.cpp:1285: Exception at tick 5143740: The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
**warptorio2**/control\_main.lua:936: attempt to concatenate field 'name' (a table value)
stack traceback:
**warptorio2**/control\_main.lua:936: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:848: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**Ferlonas (op):** It's not strictly reproducible. I think it might have happened when the warp to the homeworld worked, but I'm not sure

---
**PyroFire (mod author):** My first guess is you are using modded planets, as this is not the planetorio missing template issue.
I believe the additional planets listed with Planetorio like swamp planet may have issues.

---
**Ferlonas (op):** Nope. It happens when warping to the homeworld, it's the message after "Home sweet Home". Unfortunately I didn't find out what structure the variable "hp" has, but it seems that "hp.name" can not be used as a string for concatenation.

---
**PyroFire (mod author):** > Nope. It happens when warping to the homeworld, it's the message after "Home sweet Home". Unfortunately I didn't find out what structure the variable "hp" has, but it seems that "hp.name" can not be used as a string for concatenation.

Based on this, that is being pulled directly from the template and may be an instance of the missing template issue.
I'll include this in the list either way: <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>
