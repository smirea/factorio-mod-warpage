# krastorio2 Unknown item name: dt-fuel

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68451c52a77ee82ac82f21af
- Thread ID: 68451c52a77ee82ac82f21af
- Started by: che6ur3k

---
**che6ur3k (op):** Мод Warp Drive Machine (0.9.45) вызвал неустранимую ошибку.
Пожалуйста, сообщите об этой ошибке автору мода.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
Unknown item name: dt-fuel
stack traceback:
[C]: in function 'insert'
**mferrari\_lib**/utils.lua:324: in function 'prepare\_spidertron'
**Warp-Drive-Machine**/control-caves.lua:612: in function 'CAVE\_unlock\_ruin'
**Warp-Drive-Machine**/ship-control.lua:738: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>

it was renamed to kr-dt-fuel-cell

---
**MFerrari (mod author):** fixed
