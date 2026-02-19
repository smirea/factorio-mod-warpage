# [MOD ISSUE] Nauvis Melange Mod

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65d396266ac71e0f3e796b0f
- Thread ID: 65d396266ac71e0f3e796b0f
- Started by: nathanial321

---
**nathanial321 (op):** I received this non-recoverable error that connects between your mod and the Nauvis Melange mod. I made a post on their discussion board too.

Warp!
FNEI

#

M
1
8
Planet Clock: 17:48 Warping In: 0:00 Warpzone: 2 Autowarping In: 2:12
YARM
1
6
Notice
Rampant - Indexing surface:warpzone\_2, index:34, please wait.
You prospect your surroundings and gaze at the stars, and you wonder if this world has ever had a name.
1
The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.
2
Error while running event warptorio2::on\_tick (ID 0)
The mod Nauvis Melange (0.11.0) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event nauvis-melange::on\_entity\_cloned (ID 124)
**nauvis-melange**/scripts/control/machines.lua:7: bad argument #2 of
2 to 'get\_player' (string expected, got nil)
stack traceback:
[C]: in function 'get\_player'
**nauvis-melange**/scripts/control/machines.lua:7: in function 'handler'
**core**/lualib/event\_handler.lua:47: in function
<**core**/lualib/event\_handler.lua:45>
stack traceback:
[C]: in function 'clone\_entities'
**warptorio2**/control\_main.lua:988: in function 'Warp'
**warptorio2**/control\_main.lua:861: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function
<**warptorio2**/lib/lib\_control.lua:281>
Confirm
ALT 0
Ç
dó 00 PP
A
O
Light armor
✓ ↑
M
Production
0%
10m
0

---
**PyroFire (mod author):** This appears to be an issue with nauvis-melange and not with warptorio based on the error. the functions relevant to warptorio exclusively deal with cloning. Please inform the developers of nauvis-melange their cloning functions are broken.
