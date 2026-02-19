# Crash upon researching a technology

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6070de48115e510e4eeaa7b8
- Thread ID: 6070de48115e510e4eeaa7b8
- Started by: RazorLogic25

---
**RazorLogic25 (op):** Mod error can be found here: <https://imgur.com/a/jgOvytk>
This crash occurs when I attempt to research the tech "Warp Platform Logistics 1"

---
**PyroFire (mod author):** Seems like a clearing bug but this has not come up for loaders before.
Do you have other mods installed that change the vanilla loaders?

---
**Normal69:** YESS, this is my error too: <https://pastebin.com/dDV4RtYE>
I hope that RPG mod causes this, but I don't think so.
When I used /cheat all to get all techs at the same time, the error haven't occurred.
I say it might be wanting to put something in a place which wasn't created yet.
I'll try to research all possible technologies except this one from your tree-banch of tech, then I'll might see some useful result.

I also can send data if you request them!
Have a goodtime.

---
**Normal69:** I've researched a lot of other Warptorio stuff and removed RPG mod, and it works!
<https://cdn.discordapp.com/attachments/822183975669858354/1077968194607775764/image.png>

I must say: yippee!

---
**Connie07:** I'm facing this issue, I've tried removing all mods except for warptorio2 and its dependencies, but I end up getting an error on my save for invalid LuaEntities. I'm trying to research "Warp Platform Logistics 1" but it crashes with the following message:
"
The mod Warptorio2 (1.3.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_research\_finished (ID 18)
The mod Warptorio2 (1.3.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::script\_raised\_destroy (ID 80)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/lib/lib\_control\_cache.lua:193: in function 'raise\_type'
**warptorio2**/lib/lib\_control\_cache.lua:212: in function <**warptorio2**/lib/lib\_control\_cache.lua:212>
(...tail calls...)
**warptorio2**/control\_class\_harvester.lua:111: in function 'MakePointTeleporter'
**warptorio2**/control\_class\_harvester.lua:64: in function 'CheckTeleporterPairs'
**warptorio2**/control\_class\_harvester.lua:262: in function 'Recall'
**warptorio2**/control\_main\_helpers.lua:464: in function '?'
**warptorio2**/lib/lib\_control\_cache.lua:152: in function 'call\_ents'
**warptorio2**/lib/lib\_control\_cache.lua:395: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
[C]: in function 'destroy'
**warptorio2**/lib/lib\_control.lua:63: in function 'destroy'
**warptorio2**/lib/lib\_global.lua:193: in function 'clean'
**warptorio2**/control\_class\_harvester.lua:205: in function 'MakePointLoader'
**warptorio2**/control\_class\_harvester.lua:242: in function 'CheckPointLogistics'
**warptorio2**/control\_class\_harvester.lua:109: in function 'MakePointTeleporter'
**warptorio2**/control\_class\_harvester.lua:64: in function 'CheckTeleporterPairs'
**warptorio2**/control\_class\_teleporter.lua:78: in function '?'
**warptorio2**/control\_class\_teleporter.lua:114: in function 'DoResearchEffects'
**warptorio2**/control\_class\_teleporter.lua:129: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
stack traceback:
[C]: in function 'destroy'
**warptorio2**/lib/lib\_control.lua:63: in function 'destroy'
**warptorio2**/lib/lib\_global.lua:193: in function 'clean'
**warptorio2**/control\_class\_harvester.lua:205: in function 'MakePointLoader'
**warptorio2**/control\_class\_harvester.lua:242: in function 'CheckPointLogistics'
**warptorio2**/control\_class\_harvester.lua:109: in function 'MakePointTeleporter'
**warptorio2**/control\_class\_harvester.lua:64: in function 'CheckTeleporterPairs'
**warptorio2**/control\_class\_teleporter.lua:78: in function '?'
**warptorio2**/control\_class\_teleporter.lua:114: in function 'DoResearchEffects'
**warptorio2**/control\_class\_teleporter.lua:129: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
"

I attempted to bypass this by maybe using cheats to cheat the research in, but I was faced immediately with the same message as below:

"
The mod Warptorio2 (1.3.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_research\_finished (ID 18)
The mod Warptorio2 (1.3.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::script\_raised\_destroy (ID 80)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/control\_class\_harvester.lua:167: in function 'MakeComboA'
**warptorio2**/control\_class\_harvester.lua:158: in function 'CheckCombo'
**warptorio2**/control\_class\_harvester.lua:264: in function 'Recall'
**warptorio2**/control\_main\_helpers.lua:464: in function '?'
**warptorio2**/lib/lib\_control\_cache.lua:152: in function 'call\_ents'
**warptorio2**/lib/lib\_control\_cache.lua:395: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
[C]: in function 'destroy'
**warptorio2**/lib/lib\_control.lua:63: in function 'destroy'
**warptorio2**/lib/lib\_global.lua:193: in function 'clean'
**warptorio2**/control\_class\_harvester.lua:166: in function 'MakeComboA'
**warptorio2**/control\_class\_harvester.lua:158: in function 'CheckCombo'
**warptorio2**/control\_class\_teleporter.lua:86: in function '?'
**warptorio2**/control\_class\_teleporter.lua:114: in function 'DoResearchEffects'
**warptorio2**/control\_class\_teleporter.lua:129: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
stack traceback:
[C]: in function 'destroy'
**warptorio2**/lib/lib\_control.lua:63: in function 'destroy'
**warptorio2**/lib/lib\_global.lua:193: in function 'clean'
**warptorio2**/control\_class\_harvester.lua:166: in function 'MakeComboA'
**warptorio2**/control\_class\_harvester.lua:158: in function 'CheckCombo'
**warptorio2**/control\_class\_teleporter.lua:86: in function '?'
**warptorio2**/control\_class\_teleporter.lua:114: in function 'DoResearchEffects'
**warptorio2**/control\_class\_teleporter.lua:129: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>
"
I tried a combination of removing mods that could possibly interfere, but it would corrupt my save file and prevent me from playing my save again. Luckily, I've got a backup save.

I was wondering if there was any way to fix this problem?
