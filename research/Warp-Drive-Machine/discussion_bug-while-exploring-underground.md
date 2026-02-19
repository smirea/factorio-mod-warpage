# Bug while exploring underground

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68c76bf2958d97fd0bdae490
- Thread ID: 68c76bf2958d97fd0bdae490
- Started by: ZombieDenden

---
**ZombieDenden (op):** I was checking through a few different caves (was on to my 3rd) and encountered this error while revealing a new tunnel with my bots:

The mod Warp Drive Machine (1.0.12) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_robot\_pre\_mined (ID 18)
value for required parameter 2 (center) is missing
stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**Warp-Drive-Machine**/control-caves.lua:561: in function 'CreateRuinsRoom'
**Warp-Drive-Machine**/control-caves.lua:505: in function 'create\_room\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:445: in function 'create\_tunnel\_on\_direction'
**Warp-Drive-Machine**/control-caves.lua:286: in function 'check\_for\_tunnel'
**Warp-Drive-Machine**/control-caves.lua:251: in function 'diggy\_hole'
**Warp-Drive-Machine**/control-caves.lua:217: in function 'CAVE\_player\_mined\_entity'
**Warp-Drive-Machine**/control.lua:2273: in function <**Warp-Drive-Machine**/control.lua:2261>

---
**MFerrari (mod author):** this was already fixed on 1.0.13

---
**ZombieDenden (op):** THX!
