# Crashes when trying to return to planet

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/683ce3c0cfa9d2d21a2a7f6c
- Thread ID: 683ce3c0cfa9d2d21a2a7f6c
- Started by: Bolvangr

---
**Bolvangr (op):** Hello, the game is crashing when I try to open up the list of planets to warp back to them. Here are the crash logs:

128.921 Error MainLoop.cpp:1508: Exception at tick 25061558: The mod Warp Drive Machine (0.9.41) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_gui\_click (ID 1)
Warp-Drive-Machine/gui-control.lua:1812: attempt to concatenate local 'planet\_name' (a table value)
stack traceback:
Warp-Drive-Machine/gui-control.lua:1812: in function 'refresh\_planets\_list'
Warp-Drive-Machine/gui-control.lua:1928: in function 'show\_planets\_list\_gui'
Warp-Drive-Machine/gui-control.lua:656: in function <Warp-Drive-Machine/gui-control.lua:596>
128.921 Error ServerMultiplayerManager.cpp:84: MultiplayerManager failed: "The mod Warp Drive Machine (0.9.41) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_gui\_click (ID 1)
Warp-Drive-Machine/gui-control.lua:1812: attempt to concatenate local 'planet\_name' (a table value)
stack traceback:
Warp-Drive-Machine/gui-control.lua:1812: in function 'refresh\_planets\_list'
Warp-Drive-Machine/gui-control.lua:1928: in function 'show\_planets\_list\_gui'
Warp-Drive-Machine/gui-control.lua:656: in function <Warp-Drive-Machine/gui-control.lua:596>"

---
**MFerrari (mod author):** please try the new version

---
**Bolvangr (op):** It is working now, thank you!
