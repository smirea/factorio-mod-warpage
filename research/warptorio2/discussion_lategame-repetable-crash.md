# Lategame repetable Crash

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65f89e827e76712834fde13a
- Thread ID: 65f89e827e76712834fde13a
- Started by: master8luck

---
**master8luck (op):** stable crash after emergency warp to another planet(with minute timer). probably because left some loaders on previous location
Stacktrace:

The mod Warptorio2 (1.3.10) caused a non-recoverable error. Please report this error to the mod author. Error while running event warptorio2::on\_tick (ID 0) LuaTransportLine API call when LuaTransportLine was invalid. stack traceback: [C]: in function '**index' \_\_warptorio2**/control\_main\_helpers.lua:760: in function 'InsertWarpLane' **warptorio2**/control\_main\_helpers.lua:773: in function 'OutputWarpLoader' **warptorio2**/control\_main\_helpers.lua:764: in function 'DistributeLoaderLine' **warptorio2**/control\_main\_helpers.lua:790: in function 'TickWarploaders' **warptorio2**/control\_main\_helpers.lua:822: in function 'b' **warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**master8luck (op):** double tested - i left loader with satelite filter (receiver), and when i send satelite to consumer loader(from factory floor) - crash happening

---
**PyroFire (mod author):** Warp Loader issue
