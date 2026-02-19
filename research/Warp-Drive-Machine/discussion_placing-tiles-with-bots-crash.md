# Placing tiles with bots crash.

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/675ca94338f2ed758d5712bb
- Thread ID: 675ca94338f2ed758d5712bb
- Started by: Sir_AL

---
**Sir_AL (op):** Game crashes when placing blue solar tiles using bots in the newly unlocked solarium. Also doesn't allow them to be placed manually however it doesn't crash, but shows the red circle with a line through it. Effectively limiting it's use to only the 3x3 blue area it spawns with. Tested with both looted and crafted blue tiles. Crashed it twice before I gave up on the solarium. Made a save just before the research completes in case it's wanted for testing.

Error:

The mod Warp Drive Machine (0.9.14) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_built\_entity (ID 6)
**Warp-Drive-Machine**/control.lua:1601: attempt to index field 'harvesters' (a nil value)
stack traceback:
**Warp-Drive-Machine**/control.lua:1601: in function 'Check\_Restrict\_Building'
**Warp-Drive-Machine**/control.lua:1536: in function <**Warp-Drive-Machine**/control.lua:1527>

---
**Sir_AL (op):** Researched "Warponium" and "Warp ensured room 1" then it started to work.
