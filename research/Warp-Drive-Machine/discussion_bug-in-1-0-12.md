# bug in 1.0.12

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68b8d0e505afe284c4b05956
- Thread ID: 68b8d0e505afe284c4b05956
- Started by: che6ur3k

---
**che6ur3k (op):** Error while running event Warp-Drive-Machine::on\_robot\_pre\_mined (ID 18)
value for required parameter 2 (center) is missing
stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**Warp-Drive-Machine**/control-caves.lua:561: in function 'CreateRuinsRoom'
**Warp-Drive-Machine**/control-caves.lua:505: in function 'create\_room\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:445: in function 'create\_tunnel\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:286: in function 'check\_for\_tunnel'
**Warp-Drive-Machine**/control-caves.lua:239: in function 'diggy\_hole'
**Warp-Drive-Machine**/control-caves.lua:217: in function 'CAVE\_player\_mined\_entity'
**Warp-Drive-Machine**/control.lua:2273: in function <**Warp-Drive-Machine**/control.lua:2261>

---
**MFerrari (mod author):** fixed

---
**Binshicken:** I got the same error on version 1.0.12

stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**Warp-Drive-Machine**/control-caves.lua:561: in function 'CreateRuinsRoom'
**Warp-Drive-Machine**/control-caves.lua:505: in function 'create\_room\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:445: in function 'create\_tunnel\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:286: in function 'check\_for\_tunnel'
**Warp-Drive-Machine**/control-caves.lua:251: in function 'diggy\_hole'
**Warp-Drive-Machine**/control-caves.lua:217: in function 'CAVE\_player\_mined\_entity'
**Warp-Drive-Machine**/control.lua:2273: in function <**Warp-Drive-Machine**/control.lua:2261>
35266.437 Error ServerMultiplayerManager.cpp:84: MultiplayerManager failed: "The mod Warp Drive Machine (1.0.12) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_player\_mined\_entity (ID 72)
value for required parameter 2 (center) is missing
stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**Warp-Drive-Machine**/control-caves.lua:561: in function 'CreateRuinsRoom'
**Warp-Drive-Machine**/control-caves.lua:505: in function 'create\_room\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:445: in function 'create\_tunnel\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:286: in function 'check\_for\_tunnel'
**Warp-Drive-Machine**/control-caves.lua:251: in function 'diggy\_hole'
**Warp-Drive-Machine**/control-caves.lua:217: in function 'CAVE\_player\_mined\_entity'
**Warp-Drive-Machine**/control.lua:2273: in function <**Warp-Drive-Machine**/control.lua:2261>"
