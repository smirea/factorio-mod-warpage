# a non-recoverable error related to Loaders

- URL: https://mods.factorio.com/mod/warptorio2/discussion/61ddde7a0368d8cb0899395c
- Thread ID: 61ddde7a0368d8cb0899395c
- Started by: vicarious

---
**vicarious (op):** Steps to reproduce: Setup miners feeding on to a belt, then at the end of the belt have a splitter then two loaders. Have another loader elsewhere receiving the output. Then try to change anything with the first belt (removing the splitter, or loader, or even a belt segment). Causes crash to desktop. Only happens with items on belt. I was able to avoid error by shutting off power to the miners, letting the belt run empty, then I could tear down belt/loader without issue.
Full crash message:

The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
**warptorio2**/control\_main\_helpers.lua:757: attempt to call field 'can\_insert\_at\_back' (a nil value)
stack traceback:
**warptorio2**/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
**warptorio2**/control\_main\_helpers.lua:770: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:785: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:817: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**vicarious (op):** I had another crash to desktop also related to warp loaders.

The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
**warptorio2**/control\_main\_helpers.lua:757: attempt to call field 'can\_insert\_at\_back' (a nil value)
stack traceback:
**warptorio2**/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
**warptorio2**/control\_main\_helpers.lua:770: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:785: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:817: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** fixed in <https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66> 1.3.6
