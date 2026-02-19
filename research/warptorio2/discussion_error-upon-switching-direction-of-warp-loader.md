# Error upon switching direction of warp loader

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65e84c2e32cfddd5e8905ff0
- Thread ID: 65e84c2e32cfddd5e8905ff0
- Started by: jkism0902

---
**jkism0902 (op):** Hello. I'm getting the followed message popup as soon as I try to switch warp loader's direction and crash to the main menu.

===================================================
The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
invalid key to 'next'
stack traceback:
[C]: in function 'next'
**warptorio2**/control\_main\_helpers.lua:761: in function 'NextWarploader'
**warptorio2**/control\_main\_helpers.lua:787: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:822: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>
===================================================

And here is my mod list.

===================================================
2/22/2024 4:45 PM 14033384 aai-vehicles-miner\_0.6.5.zip
3/4/2024 5:34 PM 14033546 aai-vehicles-miner\_0.6.6.zip
2/24/2024 6:44 PM 114983697 alien-biomes\_0.6.8.zip
2/28/2024 12:55 AM 111018 assault-rifle\_1.0.4.zip
2/24/2024 6:45 PM 953371 Automatic\_Train\_Painter\_1.2.0.zip
1/16/2024 5:39 PM 148591 bobangel-pollution\_1.0.1.zip
2/24/2024 3:40 AM 21375962 bobassembly\_1.2.2.zip
1/15/2024 6:09 PM 52539 bobenemies\_1.2.0.zip
2/24/2024 3:40 AM 935004 bobequipment\_1.2.1.zip
2/19/2024 12:48 AM 137201 bobgreenhouse\_1.2.0.zip
2/26/2024 6:12 PM 156837 bobinserters\_1.2.0.zip
1/9/2024 9:04 PM 6959621 boblibrary\_1.2.0.zip
1/9/2024 9:06 PM 5379787 boblogistics-belt-reskin\_1.1.0.zip
2/24/2024 3:40 AM 27583068 boblogistics\_1.2.2.zip
1/15/2024 6:08 PM 128401 bobmodules\_1.2.0.zip
1/15/2024 6:08 PM 2329797 bobvehicleequipment\_1.2.0.zip
3/4/2024 5:34 PM 4246049 bobwarfare\_1.2.1.zip
1/16/2024 5:45 PM 73255 Bottleneck\_0.11.7.zip
2/14/2024 6:40 PM 266997 cb-science\_0.4.0.zip
2/24/2024 6:34 PM 285626 ChangeInserterDropLane\_1.0.2.zip
2/18/2024 11:17 AM 954 CheaperProcessingUnit\_1.0.0.zip
2/28/2024 5:49 PM 10707761 Cold\_biters\_1.2.1.zip
2/19/2024 12:22 AM 76031 colorblind-pollution\_0.1.2.zip
2/19/2024 12:20 AM 650464 ColorblindCircuitNetwork\_0.1.6.zip
2/14/2024 6:40 PM 72101 colorblind\_adv\_circuit\_0.0.2.zip
1/9/2024 9:04 PM 39972 combat-mechanics-overhaul\_0.6.24.zip
1/9/2024 9:04 PM 281730 CombatTechnology\_1.0.1.zip
1/22/2024 6:59 PM 96293 Electric\_Furnaces\_new\_Version\_0.0.3181.zip
2/28/2024 5:49 PM 95930404 Explosive\_biters\_2.0.5.zip
1/16/2024 5:44 PM 42412 extended-descriptions\_1.2.1.zip
2/24/2024 6:35 PM 450356 extra-storage-tank-minibuffer\_0.1.4.zip
2/28/2024 5:49 PM 6616077 factorio-crash-site\_1.0.2.zip
1/10/2024 5:11 PM 48835 far-reach\_1.1.3.zip
1/22/2024 7:01 PM 3453 FastFurnaceRecipes\_0.0.2.zip
2/14/2024 6:40 PM 1333 fireproof-bots\_1.1.3.zip
1/10/2024 5:12 PM 428469 flib\_0.13.0.zip
1/16/2024 5:54 PM 129233 FNEI\_0.4.1.zip
1/26/2024 6:01 PM 133952 FNEI\_0.4.2.zip
2/29/2024 12:03 AM 46507 FreeUnlimitedElectricEnergy\_0.0.4.zip
2/24/2024 6:40 PM 13718 GhostInHand\_1.0.6.zip
1/16/2024 5:54 PM 87768 inbuilt\_lighting\_20.1.13.zip
1/9/2024 2:22 PM 4573 InstanCraftingThings\_1.1.0.zip
2/26/2024 2:36 AM 458268 item-incineration\_1.2.0.zip
3/1/2024 10:24 PM 907473 Liquid\_Ore\_Conversion\_1.0.2.zip
1/13/2024 2:50 AM 7103 longer-pipe-to-ground\_1.0.0.zip
2/14/2024 6:40 PM 7052 longer-pipe-to-ground\_1.0.1.zip
2/27/2024 5:55 PM 4356 longer-poles\_1.0.0.zip
2/14/2024 6:40 PM 39551 manual-inventory-sort\_2.2.5.zip
2/26/2024 6:12 PM 265935 miniloader\_1.15.7.zip
1/29/2024 7:02 PM 4065451 Mining\_Drones\_1.1.10.zip
2/14/2024 6:40 PM 77837 mining\_drones\_overloaded\_1.1.0.zip
3/6/2024 7:46 PM 7077 mod-list.json
3/6/2024 7:45 PM 36863 mod-settings.dat
1/16/2024 5:55 PM 1416064 Nanobots\_3.2.19.zip
1/9/2024 9:52 PM 26157 no-wall-repair\_0.0.4.zip
3/1/2024 10:15 PM 1846853 Ore\_Conversion\_0.2.1.zip
2/28/2024 5:49 PM 61460 planetorio\_0.1.5.zip
3/4/2024 5:34 PM 305425 planetorio\_expansion\_planets\_1.0.10.zip
3/5/2024 1:31 AM 305839 planetorio\_expansion\_planets\_1.0.11.zip
2/28/2024 5:49 PM 302347 planetorio\_expansion\_planets\_1.0.5.zip
2/24/2024 3:40 AM 1059859 Power Armor MK3\_0.4.6.zip
2/24/2024 6:39 PM 52504 RailSignalPlanner\_1.2.9.zip
3/4/2024 5:34 PM 16638845 RampantArsenal\_1.1.6.zip
2/27/2024 5:55 PM 2039834 Rampant\_3.3.4.zip
1/16/2024 5:57 PM 1111458 Repair\_Turret\_1.0.3.zip
2/26/2024 1:09 AM 15700859 reskins-library\_2.1.7.zip
2/25/2024 8:11 PM 13460 ReStack\_0.7.2.zip
2/29/2024 12:03 AM 60317 rusty-locale\_1.0.16.zip
1/10/2024 5:12 PM 552576 show-max-underground-distance\_0.0.8.zip
2/24/2024 6:34 PM 6063 simhelper\_1.1.6.zip
2/29/2024 6:04 PM 883244 Small\_assembling\_0.1.5.zip
1/15/2024 6:06 PM 1582793 Solar-Lamp\_0.2.0.zip
1/15/2024 6:06 PM 2210040 solar-productivity\_0.3.4.zip
2/14/2024 6:40 PM 2210237 solar-productivity\_0.3.5.zip
1/15/2024 6:05 PM 1476569 solar-walls\_0.0.16.zip
1/10/2024 5:12 PM 138672 sonaxaton-research-queue\_0.4.21.zip
1/13/2024 2:53 AM 39959 Squeak Through\_1.8.2.zip
2/26/2024 6:12 PM 64266 Starcraft\_siege\_tank\_firing\_sound\_1.0.3.zip
1/16/2024 5:55 PM 149364 stdlib\_1.4.8.zip
1/15/2024 6:07 PM 296868 Teleporters\_1.0.5.zip
2/28/2024 5:49 PM 85747108 Toxic\_biters\_1.1.5.zip
2/26/2024 6:12 PM 21987784 Transport\_Drones\_1.0.16.zip
2/19/2024 12:26 AM 1895 Turret\_Range\_Buff\_0.4.1.zip
1/16/2024 5:56 PM 6193008 underground-pipe-pack\_1.1.2.zip
1/29/2024 7:02 PM 14357684 underground-pipe-pack\_1.1.3.zip
2/18/2024 11:40 PM 530443 uranium\_geiger\_0.4.0.zip
1/9/2024 2:11 PM 197414 visual\_tracers\_1.0.4.zip
2/26/2024 1:10 AM 4069213 Warehousing\_0.5.7.zip
2/18/2024 11:55 PM 562432 Warheads\_0.0.19.zip
2/28/2024 5:49 PM 1856169 warptorio2\_1.3.10.zip
2/28/2024 5:49 PM 2851119 warptorio2\_expansion\_1.1.93.zip
3/4/2024 5:34 PM 2854632 warptorio2\_expansion\_1.1.94.zip
3/5/2024 5:26 PM 2854660 warptorio2\_expansion\_1.1.95.zip
3/6/2024 6:18 PM 2856978 warptorio2\_expansion\_1.1.98.zip
1/10/2024 5:10 PM 60913 Waterfill\_v17\_1.1.0.zip
2/15/2024 11:22 PM 426346 Wood\_Gasification\_3.2.0.zip

---
**orderbringer:** Hi PyroFire! Thanks for this awesome mod! I'm also encountering a reproducable error related to Warploaders, but only when transporting artillery shells.

* I have one warploader receiving artillery shells. I place a warploader to output shells. I configure the filter to output shells. I close the filter window. => Error.
* I have no warploader receiving artillery shells. I place a warploader to output shells. I configure the filter to output shells. I close the filter window. I place the warploader receiving artillery shells. => Error.

In both cases the "surface" doesn't matter (factory floor, outside i. e. non-warp platform, harvester etc.). Setting any other filter than artillery shells doesn't trigger the error (so far).

Keep up the good work! I'll be patient until and happy when you release an update/bugfix :).

=== Error ===
The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
invalid key to 'next'
stack traceback:
[C]: in function 'next'
**warptorio2**/control\_main\_helpers.lua:761: in function 'NextWarploader'
**warptorio2**/control\_main\_helpers.lua:773: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:764: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:790: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:822: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281

=== Modlist ===
aai-containers\_0.2.11
alien-biomes\_0.6.8
bobinserters\_1.2.0
BottleneckLite\_1.2.8
CombatTechnology\_1.0.1
DeadlockResearchNotifications\_1.0.2
even-distribution\_1.0.10
EvoGUI\_0.4.601
Fill4Me-fixed\_0.10.1
flib\_0.13.0
FNEI\_0.4.2
informatron\_0.3.4
Mining\_Drones\_Remastered\_2.0.15
Nanobots\_3.2.19
planetorio\_0.1.5
production-monitor\_1.1.3
ProgressiveRunningRevived\_1.0.3
pump\_1.3.4
RateCalculator\_3.2.4
scattergun\_turret\_7.4.1
stdlib\_1.4.8
TimeTools\_2.1.44
warptorio2\_1.3.10
warptorio2-warp-harvester-indoor-drill-placement\_1.0.3

---
**PyroFire (mod author):** I'm glad the warploaders have worked as well as they have for you with that many mods loaded.
Unfortunately this error is not trivial, and with only 2 relevant reports it will be difficult to debug.
I'll need to keep watch of this one as it is not one for the list of flaws yet.
