# Removed planet mod crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/689bcbcfd0c49f4356ae2fdb
- Thread ID: 689bcbcfd0c49f4356ae2fdb
- Started by: fbserg

---
**fbserg (op):** Once Cerys mod is removed after it's been visited, there's a crash on opening the planet warp choice:

Error while running event Warp-Drive-Machine::on\_gui\_click (ID 1)
Unknown sprite "space-location/cerys"
stack traceback:
[C]: in function 'add'
**Warp-Drive-Machine**/gui-control.lua:1847: in function 'refresh\_planets\_list'
**Warp-Drive-Machine**/gui-control.lua:1927: in function 'show\_planets\_list\_gui'
**Warp-Drive-Machine**/gui-control.lua:655: in function <**Warp-Drive-Machine**/gui-control.lua:595>

---
**MFerrari (mod author):** fixed
