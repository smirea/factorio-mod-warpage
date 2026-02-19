# Won't let me start a game with the mod

- URL: https://mods.factorio.com/mod/warptorio2/discussion/61d504909adaeaca56ff6dcb
- Thread ID: 61d504909adaeaca56ff6dcb
- Started by: kulg

---
**kulg (op):** The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_init()
Unknown tile name: warp-tile-concrete
stack traceback:
[C]: in function 'set\_tiles'
**warptorio2**/lib/lib\_global.lua:182: in function 'LayTiles'
**warptorio2**/control\_platform\_classic.lua:501: in function <**warptorio2**/control\_platform\_classic.lua:493>
(...tail calls...)
**warptorio2**/control\_main.lua:170: in function 'ConstructPlatform'
**warptorio2**/control\_main.lua:236: in function 'InitPlatform'
**warptorio2**/control\_main.lua:333: in function 'v'
**warptorio2**/lib/lib\_control.lua:270: in function 'raise\_migrate'
**warptorio2**/control\_main.lua:248: in function 'v'
**warptorio2**/lib/lib\_control.lua:269: in function <**warptorio2**/lib/lib\_control.lua:269>

---
**PyroFire (mod author):** You are the first to report this issue.
I suspect something wrong with your copy of the mod, like file corruption.
Try deleting it from your mods folder and re-download.
Failing that, my next best guess is it is a mod conflict.
