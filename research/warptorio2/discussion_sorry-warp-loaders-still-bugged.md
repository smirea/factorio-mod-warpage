# Sorry Warp Loaders still bugged

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5f69f72a8797194da1556e89
- Thread ID: 5f69f72a8797194da1556e89
- Started by: CaptainSlide

---
**CaptainSlide (op):** Warp loaders now accept inputs, however the filter option to get a specific out put is not working properly now. Basically get a random out put of all items, in the buffer, which is not really useful. Also when you try to pick up a loader I get this=
The mod Warptorio2 (1.3.1) caused a non-recoverable error.
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
Hope you can figure out what it means.
Thx

---
**CaptainSlide (op):** Upon Further investigation it seems that you can only use one type of item at a time. The second loader seems to stop accepting items once what seems to be a buffer is full (hidden chest). This is not how it has worked in the past.

Also if you empty the system of all items you can pick up the loader without a crash.

Perhaps loaders need to be linked in pairs with their own buffer. perhaps filter inputs and outputs to specify a pair.

---
**Sciencefreak:** There is also a minor bug if you set the same filter twice on a single loader output (e.g. you choose stone twice out of the 5 slots). It also makes the mod to crash the game

---
**PyroFire (mod author):** This is a different problem to code being missing.

---
**PyroFire (mod author):** Added to list of flaws and merged with <https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66>

---
**PyroFire (mod author):** Fixed in <https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66> 1.3.6
