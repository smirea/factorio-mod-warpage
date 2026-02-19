# 有bug

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6743055e46891a81fe7fdf8b
- Thread ID: 6743055e46891a81fe7fdf8b
- Started by: Aba-Aba.

---
**Aba-Aba. (op):** After researching Thor, going to a planet containing scrap gives an error, and then trying to travel to another planet is not possible

---
**MFerrari (mod author):** Please print the error

---
**Aba-Aba. (op):** Error while running event Warp-Drive-Machine::on nth tick(30)Warp-Drive-Machine\_\_/warp-control.ua:471: attempt to index global 'setting(a nil value)
stack traceback:
Warp-Drive-Machine\_\_/warp-control.lua:471: in function 'warp\_now-*Warp-Drive-Machine\_\_/ship-control.lua:548: in function'update\_ships\_each\_second'
Warp-Drive-Machine*/control.lua:716: in functionWarp-Drive-Machine /control.lua:715>

---
**MFerrari (mod author):** fixed

---
**Aba-Aba. (op):** 然后无法点击飞船终端
Error while running event Warp-Drive-Machine::on\_gui\_opened (lD 95)Invalid selected index -out of bounds.stack traceback:
[C]: in function 'add'
Warp-Drive-Machine\_\_/gui-control.lua:1192: in function'update\_ship\_terminal\_gui'
Warp-Drive-Machine\_\_/gui-control.lua:1311: in function'ship\_terminal\_gui\_opened'
Warp-Drive-Machine\_\_/gui-control.lua:732: in function<**Warp-Drive-Machine**/gui-control.lua:724>
