# Crash with beacon replacement mod

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/692cab9ab95a253674df06e6
- Thread ID: 692cab9ab95a253674df06e6
- Started by: Sandact6

---
**Sandact6 (op):** I got a crash when attempting to use a mod that gives the player the Space Exploration kind of beacons. Please let me know if you need any other information.

The mod Warptorio 2.0 (Space Age) (0.2.12) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_tick (ID 0)
The mod Beacon Rebalance (2.0.3) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event wret-beacon-rebalance-mod::on\_entity\_cloned (ID 139)
**wret-beacon-rebalance-mod**/control.lua:79: attempt to index field 'entity' (a nil value)
stack traceback:
**wret-beacon-rebalance-mod**/control.lua:79: in function <**wret-beacon-rebalance-mod**/control.lua:76>
stack traceback:
[C]: in function 'clone\_area'
**warptorio-space-age**/control.lua:1242: in function 'teleport\_ground'
**warptorio-space-age**/control.lua:1491: in function 'next\_warp\_zone\_space'
**warptorio-space-age**/control.lua:1547: in function 'next\_warp\_zone'
**warptorio-space-age**/control.lua:1749: in function <**warptorio-space-age**/control.lua:1695>
