# Crash on mining Harvester Platform on surface

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5ee4f34f94f344000c6a7242
- Thread ID: 5ee4f34f94f344000c6a7242
- Started by: Legend7

---
**Legend7 (op):** Couldn't reproduce it again after reloading. Hope the stack trace helps.

The mod Warptorio2 (1.2.8) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_player\_mined\_entity (ID 65)
highlight-box needs either a bounding\_box, source or target
stack traceback:
**warptorio2**/control\_class\_harvester.lua:320: in function 'Recall'
**warptorio2**/control\_main\_helpers.lua:464: in function '?'
**warptorio2**/lib/lib\_control\_cache.lua:152: in function 'call\_ents'
**warptorio2**/lib/lib\_control\_cache.lua:398: in function 'y'
**warptorio2**/lib/lib\_control.lua:287: in function <**warptorio2**/lib/lib\_control.lua:287>
stack traceback:
[C]: in function 'clone\_entities'
**warptorio2**/control\_class\_harvester.lua:320: in function 'Recall'
**warptorio2**/control\_main\_helpers.lua:464: in function '?'
**warptorio2**/lib/lib\_control\_cache.lua:152: in function 'call\_ents'
**warptorio2**/lib/lib\_control\_cache.lua:398: in function 'y'
**warptorio2**/lib/lib\_control.lua:287: in function <**warptorio2**/lib/lib\_control.lua:287>

---
**Legend7 (op):** The highlight that triggers the error is a unconnected pipe on the harvester platform with this mod. <https://mods.factorio.com/mod/PickerPipeTools>

---
**PyroFire (mod author):** i broke this a while ago. Checked the code seems like it'll work just to turn it on.

---
**Ferlonas:** What do you mean by "turn it on"? It's unfortunately still broken
