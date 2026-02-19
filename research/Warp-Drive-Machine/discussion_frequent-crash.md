# frequent crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/65fd5f1bbb78c23eec898ba7
- Thread ID: 65fd5f1bbb78c23eec898ba7
- Started by: JGAO

---
**JGAO (op):** Hi, my server crashed multiple times and all are exactly during warpping. The error messages are mostly like this and they all contain the following three lines.
"
**Warp-Drive-Machine**/warp-control.lua:117: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:343: in function 'warp\_now'
\_\_Warp-Drive-Machine\_\_ip-control.lua:394: in function 'update\_ships\_each\_second'
"

969.524 Error MainLoop.cpp:1404: Exception at tick 397860: The mod Warp Drive Machine (0.1.31) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:49: attempt to index local 'autoplace' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:49: in function 'set\_autoplace\_value'
**Warp-Drive-Machine**/warp-control.lua:117: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:343: in function 'warp\_now'
**Warp-Drive-Machine\_\_ip-control.lua:394: in function 'update\_ships\_each\_second'
\_\_Warp-Drive-Machine**/control.lua:474: in function <**Warp-Drive-Machine**/control.lua:473>
969.524 Error ServerMultiplayerManager.cpp:92: MultiplayerManager failed: "The mod Warp Drive Machine (0.1.31) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:49: attempt to index local 'autoplace' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:49: in function 'set\_autoplace\_value'
**Warp-Drive-Machine**/warp-control.lua:117: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:343: in function 'warp\_now'
**Warp-Drive-Machine\_\_ip-control.lua:394: in function 'update\_ships\_each\_second'
\_\_Warp-Drive-Machine**/control.lua:474: in function <**Warp-Drive-Machine**/control.lua:473>"
969.524 Info ServerMultiplayerManager.cpp:816: updateTick(397860) changing state from(InGame) to(Failed)
969.525 Quitting: multiplayer error.

---
**MFerrari (mod author):** Hi. Can you share a saved game file ? show me your mod list ?

---
**JGAO (op):** Sure, here are two sets of save files and the corresponding mod setting & list files. Type 2 is more important for now.

<https://drive.google.com/drive/folders/1rQ_E-QONTXV9hQz1G9Vpeo82UYD50G8z?usp=sharing>

(Type 1, 100% reproducable)Initially, I played WDM + K2 + 248k + some enforced enemy mods + dark scene, as shown in the first save file.It 100% crashed after several warps. You can 100% reproduce the crash after the immediate following warp.The interesting thing is, even if I tried loading the save while removing all other mods except for WDM's core dependencies, it still crashed.

(Type2, more important, high chance but not not 100%) .(can manually click the warp button after loading the save file) After that, I removed K2(mining its shelter could cause another type of crash) , kept all others and started a new game.The game became playable though it stil has a certain change to crash. When this happened, I had to load a previous save so that it had a change to survive. Most of the time the crash happened when the ship docked at the space shop or when after we stayed long on one planet

The following error is the most common crash error(type 2) I have till now.

Error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/control-functions.lua:77: attempt to perform arithmetic on field '?' (a nil value)
stack traceback:
**Warp-Drive-Machine**/control-functions.lua:77: in function 'get\_tech\_force\_offers'
**Warp-Drive-Machine**/control-space-station.lua:104: in function 'SPACE\_STATION\_arrive'
**Warp-Drive-Machine**/warp-control.lua:570: in function 'post\_warp\_routines'
**Warp-Drive-Machine**/warp-control.lua:539: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:394: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:474: in function <**Warp-Drive-Machine**/control.lua:473>
1305.633 Error ServerMultiplayerManager.cpp:92: MultiplayerManager failed: "The mod Warp Drive Machine (0.1.31) caused a non-recoverable error.
Please report this error to the mod author.
Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/control-functions.lua:77: attempt to perform arithmetic on field '?' (a nil value)
stack traceback:
**Warp-Drive-Machine**/control-functions.lua:77: in function 'get\_tech\_force\_offers'
**Warp-Drive-Machine**/control-space-station.lua:104: in function 'SPACE\_STATION\_arrive'
**Warp-Drive-Machine**/warp-control.lua:570: in function 'post\_warp\_routines'
**Warp-Drive-Machine**/warp-control.lua:539: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:394: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:474: in function <**Warp-Drive-Machine**/control.lua:473>"
1305.633 Info ServerMultiplayerManager.cpp:816: updateTick(5528880) changing state from(InGame) to(Failed)
1305.633 Quitting: multiplayer error.

---
**JGAO (op):** Here is a quick look of my mod list. You can check them in detail using the mod list & setting files on google drive.

Type 1mod list:
base 1.1.104
combinator-stack-button 0.0.1
nach0\_library 0.0.2
zhcnremake 2.0.2
aai-signal-transmission 0.4.9
adjustable\_flashlight 0.0.3
advanced-centrifuge 1.0.3
alien-biomes 0.6.8
ArachnidsFaction 1.1.4
BigPumpjack 0.0.4
blueprint\_flip\_and\_turn 101.8.6
Clockwork 1.1.1
console-extended 1.1.0
CustomCircuitColors 1.2.2
DeadlockLargerLamp 1.5.1
dim\_lamps 0.0.2
electricboiler 1.1.0
even-distribution 1.0.10
factorio-crash-site 1.0.2
flib 0.13.0
FNEI 0.4.2
grappling-gun 0.3.3
informatron 0.3.4
inventory-repair 19.1.1
Krastorio2Assets 1.2.2
liborio 1.1.1
manual-inventory-sort 2.2.5
mferrari-mod-sounds 1.0.1
mining-patch-planner 1.5.8
ModuleInserterSimplified 1.1.4
Natural\_Evolution\_Graphics 1.1.2
Nightfall 1.1.1
OmegaDrill 0.2.3
planetorio 0.1.5
Portals 0.7.1
pump 1.3.4
Repair\_Turrets 1.0.11
Robot256Lib 1.1.5
Rocket-Silo-Construction 1.3.6
RPGsystem 1.3.5
rusty-locale-xeraph 0.1.0
scrap-resource 0.2.0
Searchlight 1.1.2
simple-qol 1.0.1
some-luaconsole 1.1.5
space-exploration-graphics 0.6.17
Squeak Through 1.8.2
Todo-List 19.3.0
VisionRadar 1.2.1
Arachnids\_enemy 1.0.2
ArmouredBiters 1.1.9
BottleneckLite 1.2.8
Cold\_biters 1.2.1
crafting\_combinator\_xeraph 0.4.3
factoryplanner 1.1.78
heroturrets 1.1.22
Krastorio2 1.3.23
ModuleInserterEx 6.1.2
resourcehighlighter-dark 2.5.2
Toxic\_biters 1.1.5
248k 1.0.29
Explosive\_biters 2.0.5
RampantFixed 1.8.4
recipe-tweaker 0.0.9
wret-beacon-rebalance-mod 1.0.15
Big-Monsters 1.4.0
nach0\_248k\_k2\_compat\_patch 0.0.1
planetorio\_expansion\_planets 1.0.12
Warp-Drive-Machine 0.1.31
aotixzhcn 2.4.1

---

Type 2 mod list:
base 1.1.104
combinator-stack-button 0.0.1
recipe-tweaker 0.0.9
zhcnremake 2.0.2
aai-signal-transmission 0.4.9
adjustable\_flashlight 0.0.3
advanced-centrifuge 1.0.3
alien-biomes 0.6.8
ArachnidsFaction 1.1.4
BigPumpjack 0.0.4
blueprint\_flip\_and\_turn 101.8.6
Clockwork 1.1.1
console-extended 1.1.0
CustomCircuitColors 1.2.2
DeadlockLargerLamp 1.5.1
dim\_lamps 0.0.2
electricboiler 1.1.0
even-distribution 1.0.10
exotic-industries-containers 0.0.5
exotic-industries-loaders 0.0.3
factorio-crash-site 1.0.2
flib 0.13.0
FNEI 0.4.2
grappling-gun 0.3.3
informatron 0.3.4
inventory-repair 19.1.1
liborio 1.1.1
manual-inventory-sort 2.2.5
mferrari-mod-sounds 1.0.1
mining-patch-planner 1.5.8
ModuleInserterSimplified 1.1.4
Natural\_Evolution\_Graphics 1.1.2
Nightfall 1.1.1
OmegaDrill 0.2.3
planetorio 0.1.5
Portals 0.7.1
pump 1.3.4
RampantArsenal 1.1.6
Repair\_Turrets 1.0.11
Robot256Lib 1.1.5
Rocket-Silo-Construction 1.3.6
RPGsystem 1.3.5
rt-light-bot-start 1.0.0
rusty-locale-xeraph 0.1.0
Searchlight 1.1.2
simple-qol 1.0.1
some-luaconsole 1.1.5
space-exploration-graphics 0.6.17
Squeak Through 1.8.2
Todo-List 19.3.0
VisionRadar 1.2.1
wret-beacon-rebalance-mod 1.0.15
248k 1.0.29
Arachnids\_enemy 1.0.2
ArmouredBiters 1.1.9
BottleneckLite 1.2.8
Cold\_biters 1.2.1
crafting\_combinator\_xeraph 0.4.3
factoryplanner 1.1.78
heroturrets 1.1.22
ModuleInserterEx 6.1.2
resourcehighlighter-dark 2.5.2
Toxic\_biters 1.1.5
Explosive\_biters 2.0.5
RampantFixed 1.8.4
Big-Monsters 1.4.0
planetorio\_expansion\_planets 1.0.12
Warp-Drive-Machine 0.1.31
aotixzhcn 2.4.1

---
**MFerrari (mod author):** goshhh
Wich one of these mods changes resources ? The crash is related to resources...

---
**JGAO (op):** The abandoned Type 1 mod list has Krastorio2 that adds some resource types.

For now, for the type2 mod list we created a new game. I don't think any mod changes resources, more precisely in terms of types and distribution. 248k overhaul does not introduce new resources.

I also tried Scrap Resource and finally removed it. But I dont remember if that was added during the Type 2 game play, and if it somehow "left something and contaminated the WDM mod" after removal.
<https://mods.factorio.com/mod/scrap-resource>

---
**MFerrari (mod author):** please try the new version

---
**JGAO (op):** It still crashes when arriving at a space shop. More concretely, I found disabling space traveling in mod map setting would solve the problem so I disabled it before this update so everything went well. I then updated WDM and still kept space traveling disabled for several hours and nothing happened. Finally the game crashed after I turned on space traveling and after it docked at a space shop.

---
**MFerrari (mod author):** I will release a new version. It wont crash in this new case, but I dont think you will be able to play with 248k mod... many machines will not be allowed to be built in any tile...

---
**JGAO (op):** Thanks. Yeah, actually I unlocked the green tile using console at the begining and changed the ingradient of it to 1000 brick using mod recipe-tweaker 0.0.9 as listed above.

<https://mods.factorio.com/mod/recipe-tweaker>
