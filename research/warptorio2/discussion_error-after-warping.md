# Error after warping

- URL: https://mods.factorio.com/mod/warptorio2/discussion/646ab1b709c19507a69bc86c
- Thread ID: 646ab1b709c19507a69bc86c
- Started by: carthinain

---
**carthinain (op):** After 1000 some minutes on a world researching alot i decided to warp and got this error message

The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
The mod Factorissimo 2 - notnotmelon fork (1.2.3) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event factorissimo-2-notnotmelon::on\_entity\_cloned (ID 123)
**factorissimo-2-notnotmelon**/script/connections/belt.lua:69: attempt to index local 'outside\_link' (a nil value)
stack traceback:
**factorissimo-2-notnotmelon**/script/connections/belt.lua:69: in function '?'
...ssimo-2-notnotmelon\_\_/script/connections/connections.lua:133: in function 'init\_connection'
...ssimo-2-notnotmelon\_\_/script/connections/connections.lua:179: in function 'recheck\_factory'
**factorissimo-2-notnotmelon**/control.lua:471: in function 'create\_factory\_exterior'
**factorissimo-2-notnotmelon**/control.lua:849: in function <**factorissimo-2-notnotmelon**/control.lua:840>
stack traceback:
[C]: in function 'clone\_entities'
**warptorio2**/control\_main.lua:988: in function 'Warp'
**warptorio2**/control\_main.lua:861: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** Hi, this is an issue with the mod "factorissimo-2-notnotmelon" and not with Warptorio2. I encourage you to link the associated bug report discussion thread in this one so we can all bug-track this together :)

---
**NanitOne:** Had this error today as well, after trying things out it appears to happen when we first placed a (red) belt connection from a tier 2 factorissimo building to the outside. This was on the overworld level. Removing this belt fixed it for now as well :)
