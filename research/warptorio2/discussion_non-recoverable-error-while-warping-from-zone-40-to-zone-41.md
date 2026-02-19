# non-recoverable error while warping from zone 40 to zone 41

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6268dd36edc355ee2b579887
- Thread ID: 6268dd36edc355ee2b579887
- Started by: GuiltyNeko

---
**GuiltyNeko (op):** As the title says. I've reloaded the save quite a number of times without any sort of success. Not much else to say here.

The mod Warptorio2 (1.3.8) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
**warptorio2**/lib/lib\_control.lua:55: attempt to index local 'e' (a nil value)
stack traceback:
**warptorio2**/lib/lib\_control.lua:55: in function 'protect'
**warptorio2**/control\_class\_teleporter.lua:224: in function 'MakePointTeleporter'
**warptorio2**/control\_class\_teleporter.lua:177: in function 'CheckTeleporterPairs'
**warptorio2**/control\_main.lua:1044: in function 'WarpPost'
**warptorio2**/control\_main.lua:862: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:235: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**GuiltyNeko (op):** Right, well, if I leave the factory floor or whatever it's called to go kill the biters, everything works perfectly fine. If I don't, I get the error. I can only assume there's some biter, or maybe a worm, that doesn't like being teleported?

---
**PyroFire (mod author):** > Right, well, if I leave the factory floor or whatever it's called to go kill the biters, everything works perfectly fine. If I don't, I get the error. I can only assume there's some biter, or maybe a worm, that doesn't like being teleported?

It does seem that way, in a sense.
Warptorio is deliberately coded to crash instead of silently fail when some platform building is not spawned correctly.

To my knowledge, biters are not treated like players where they will be simply teleported out of the way, so right now it is crashing if that were to happen, but this would be a sufficient solution to the issue.
i'll look at putting this in the next update.

Thanks for the report!
