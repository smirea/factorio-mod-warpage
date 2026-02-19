# Crash when Warp Stabilizer accumulator finishes charging

- URL: https://mods.factorio.com/mod/warptorio/discussion/5ce04dd88caa6d000ca8b399
- Thread ID: 5ce04dd88caa6d000ca8b399
- Started by: Disferente

---
**Disferente (op):** 3986.630 Error MainLoop.cpp:1183: Exception at tick 194160: The mod Warptorio caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio::on\_tick (ID 0)
Given entity doesn't exist anymore.
stack traceback:
**warptorio**/control.lua:369: in function <**warptorio**/control.lua:304>
stack traceback:
[C]: in function 'set\_multi\_command'
**warptorio**/control.lua:369: in function <**warptorio**/control.lua:304>

Don't know if it makes a difference, but the accumulator did not charge completely before I warped first time after research of it. Then when it finished charging I got that error.

---
**NONOCE (mod author):** I found this bug not so long ago. It SHOULD be fixed with the last version.

---
**Disferente (op):** That was quick, thanks.
