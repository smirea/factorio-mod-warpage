# Crash when remove Space Age mod

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68a723d9b123fe7821cfd778
- Thread ID: 68a723d9b123fe7821cfd778
- Started by: mrmkonline

---
**mrmkonline (op):** Crash when removing Space Age mod when warp or in space

Error while running event Warp-Drive-Machine::on\_tick (ID 0)
LuaSurface API call when LuaSurface was invalid.
stack traceback:
[C]: in function '**index'
\_\_Warp-Drive-Machine**/ship-control.lua:115: in function 'is\_this\_in\_the\_ship\_planet'
**Warp-Drive-Machine**/ship-control.lua:920: in function 'update\_ship\_pipes'
**Warp-Drive-Machine**/control.lua:755: in function <**Warp-Drive-Machine**/control.lua:754>

---
**rullaf:** Hitting the same issue in current version

```
The mod Warp Drive Machine (1.0.13) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on_nth_tick(30)
LuaSurface API call when LuaSurface was invalid.
stack traceback:
    [C]: in function '__newindex'
    __Warp-Drive-Machine__/warp-control.lua:857: in function 'warp_now'
    __Warp-Drive-Machine__/ship-control.lua:647: in function 'update_ships_each_second'
    __Warp-Drive-Machine__/control.lua:775: in function <__Warp-Drive-Machine__/control.lua:774>
```

---
**MFerrari (mod author):** you cant remove SA after the game started... it breaks everything
