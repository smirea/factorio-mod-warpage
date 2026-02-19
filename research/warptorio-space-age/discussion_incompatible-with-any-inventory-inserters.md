# Incompatible with any-inventory-inserters

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/68a0d6c618de0175dcf3d231
- Thread ID: 68a0d6c618de0175dcf3d231
- Started by: mcmodderHD

---
**mcmodderHD (op):** Error occuring on Warping when having the mod "any-inventory-inserters" installed
(<https://mods.factorio.com/mod/any-inventory-inserters>)

Error while running event warptorio-space-age::on\_tick (ID 0)
The mod Any Inventory Inserters (0.0.3) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event any-inventory-inserters::on\_entity\_cloned (ID 136)
**any-inventory-inserters**/control.lua:57: attempt to index local 'entity' (a nil value)
stack traceback:
**any-inventory-inserters**/control.lua:57: in function <**any-inventory-inserters**/control.lua:51>
stack traceback:
[C]: in function 'clone\_area'
**warptorio-space-age**/control.lua:1042: in function 'teleport\_ground'
**warptorio-space-age**/control.lua:1159: in function 'next\_warp\_zone\_finish'
**warptorio-space-age**/control.lua:1521: in function <**warptorio-space-age**/control.lua:1496>
