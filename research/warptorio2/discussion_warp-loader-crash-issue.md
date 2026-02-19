# Warp Loader crash + issue

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5f45c3e5dbe18e4ef416e58f
- Thread ID: 5f45c3e5dbe18e4ef416e58f
- Started by: Ferlonas

---
**Ferlonas (op):** Got a crash when mining a warp loader (via deconstruction planner)

15054.895 Error MainLoop.cpp:1207: Exception at tick 28380893: The mod Warptorio2 (1.3.1) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
LuaTransportLine API call when LuaTransportLine was invalid.
stack traceback:
**warptorio2**/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
**warptorio2**/control\_main\_helpers.lua:775: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:785: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:817: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
**warptorio2**/control\_main\_helpers.lua:775: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:785: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:817: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

Edit: Scratch the issue, that was an error on my part. But the crash occurs after a certain time, not on deconstruction.

---
**PyroFire (mod author):** added to list of flaws. Refer to <https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66>

---
**PyroFire (mod author):** Fixed in <https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66> 1.3.6
