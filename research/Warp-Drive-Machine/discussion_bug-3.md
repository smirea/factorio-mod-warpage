# bug

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/688b6a8fe8c48516e4f8d18a
- Thread ID: 688b6a8fe8c48516e4f8d18a
- Started by: KuGua33

---
**KuGua33 (op):** 24915.225 Error MainLoop.cpp:1510: Exception at tick 14117215: The mod Warp Drive Machine (0.9.53) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_entity\_died (ID 4)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_Warp-Drive-Machine**/control.lua:2092: in function <**Warp-Drive-Machine**/control.lua:2070>
24915.225 Error ServerMultiplayerManager.cpp:84: MultiplayerManager failed: "The mod Warp Drive Machine (0.9.53) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_entity\_died (ID 4)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_Warp-Drive-Machine**/control.lua:2092: in function <**Warp-Drive-Machine**/control.lua:2070>"
24915.225 Info ServerMultiplayerManager.cpp:808: updateTick(14117215) changing state from(InGame) to(Failed)
24915.225 Quitting: multiplayer error.
