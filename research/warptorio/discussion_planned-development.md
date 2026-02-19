# Planned Development

- URL: https://mods.factorio.com/mod/warptorio/discussion/5d2aa71d8c32af000d342d9d
- Thread ID: 5d2aa71d8c32af000d342d9d
- Started by: PyroFire

---
**PyroFire (op):** # Warptorio2.

# <https://mods.factorio.com/mod/warptorio2>

![](https://assets-mod.factorio.com/assets/ext/6c6176f1a4ec0b4d635c25f8419c33e8cb39090880dd31a64a9aacba3ec346c1.gif)

---

Hi Factorians,
I quite like this mod so I have decided to develop it further.

Credit to Kitch (youtuber) where i learned about this mod - <https://www.youtube.com/watch?v=KD9mVDueHTc>
Credit to Nonoce for originally creating this fantastic mod - <https://mods.factorio.com/mod/warptorio>

I'm very experienced with lua but i have never written for factorio before so this is my first project.
It has been fun learning the factorio API and libraries with help from Nonoce's code.

This thread is to give you an idea of what i'm doing, and for people to make suggestions for improvements or new features.
I'm open to all feedback and suggestions.
I have made a discord for this mod, please stop by and leave a comment, or if you want to talk about the mod.
<https://discord.gg/a9CNarA>

I would very much appreciate a response from Nonoce, the original developer of this mod.

---

Here's a few SPOILERS screenshots of what i've already done:

**SPOILERS**
- More platform upgrades: <https://gyazo.com/b36c8a232b0555a268e03e774724c2e2>
- Improved Workfloor Beacon: <https://gyazo.com/c0e912a1014a8b0c1723b94502427139>
- Planets: <https://gyazo.com/dda0b38ff895f18de0baf9a1997a421e>
- Platform Shapes: <https://gyazo.com/012be9fe8105a36196ef8824a1d40f4a>
- More Platform Shapes & abilities: <https://gyazo.com/27d0b9713f36fd32d2d1265ae40f73c3>
- Directional loaders, circuit connections and requester/active provider teleporter chests: <https://gyazo.com/cd14c6cd31cba9971ea12257a482a593>
**SPOILERS**

---

New features and stuff:

* **(DONE)** Re-balancing of Warp-Miner productivity upgrade
* **(DONE)** Character mining speed upgrades
* **(DONE)** Buffer Chest upgrades for the underground entrances and teleporters
* **(DONE)** Separation of platform size researches (so you know what you're upgrading)
* **(DONE)** Different planets to warp to, creating some variety and a reason to buffer resources.
* **(DONE)** Power Armor Mk3 ("Warp Armor")
* **(DONE)** A small amount of water for the boiler room
* **(DONE)** Pipes should be uni-directional. Use pumps to empty them.
* **(DONE)** Loaders directions should determine how resources are transferred between floors
* **(DONE)** Pollution from the lower floors should be transported to the surface, but isn't.
* **(DONE)** Circuit connections between floors
* **(DONE)** More underground entrances
* **(DONE)** Platform shapes (squares are boring)
* **(DONE)** Extra stack and non-stack inserter upgrades
* **(DONE)** Extra bot speed and bot capacity upgrades
* **(DONE)** Remove energy cost of transporting resources through teleporter and underground chests and pipes, including for player teleporter.
* **(DONE)** Fix bugs persistence of energy and chest contents of teleporters and underground entrances between warps and upgrades
* **(DONE)** Fix bugs persistence of circuit connections of underground entrances to platform entities between warps
* **(DONE)** Fix bugs Power supply issues between floors. The problem was the accumulators don't charge correctly between eachother. These items will be removed/changed, and this is no longer an issue. The teleporter also didn't charge. This too is fixed.
* **(DONE)** Requester/ActiveProvider chest upgrades for the teleporters and underground entrances, instead of buffer chests
* **(DONE)** Partial Factorissimo Support. Works underground only. On planet surface they will break between warps.
* **(DONE)** A second set of loaders to the teleporter/underground chests, for a total of 4 belts each instead of 2.
* **(DONE)** 8 belts on main underground entraces.
* **(DONE)** Re-work warp energy and warp reactor into something new.
* **(DONE)** Teleporter requester chests circuit conditions will default to "set-request". It seems unlikely to ever need the read-contents on the requester. Read from the destination chest instead.
* **(DONE)** Space Science level upgrades and space factory and boiler floor upgrades
* **(DONE)** Warp Reactor Steering/endgame
* **(DONE)** Special Rail Logistics
* **(DONE)** Accelerator, Stabilizer & Radar platform abilities.
* **(DONE)** Warp Reactor Storyline/earlygame/autowarping/warp-timer. I didn't add a cooldown. Instead, certain planets can affect the warp charge timer.
* **(DONE)** Localization (en)
* **(DONE)** Fix bugs Teleporter gate placement errors
* **(DONE)** Warp Reactor Fuel Rods
* **(DONE)** Minimap issues underground
* **(DONE)** Playtest general bug hunting and bug fixing
* **(DONE)** Multiplayer Support.
* **(DONE)** Tiny amount of all resources to all planets
* **(DONE)** Factory platform progression alignment issues
* **(DONE)** Longer warp charge timer, needs to be several minutes and countdown passively at a slow rate to 30 seconds.
* **(DONE)** Directional Train Loaders (load/unload)
* **(DONE)** Tweak technologies, prerequisites and costs
* **(DONE)** Warptorio Migration Script (Yay saves!). It unlocks enough platform size research upon migration to have a large enough platform for everything. Though i recommend starting a new save.
* **(DONE)** Make hazard tiles more accurate, and only remove what is needed when upgrading platform logistics and entrances
* **(DONE)** Quality-Of-Life tweaks to teleporter behavior to prevent disorientation when teleporting.
* **(DONE)** Ensure teleporter cannot be lost or permanently destroyed & fixes for potential glitches
* **(DONE)** Re-color the Warp Pipes
* **(DONE)** Add sub-icons to researches for uniqueness, and particularly to help with identifying researches affecting the corners.
* **(DONE)** Add special power pole to boiler room
* **(DONE)** Space Science - Warp Modules
* **(DONE)** Space Science - Warp Roboport (more charging slots)
* **(DONE)** Character Reach upgrades
* **(DONE)** A reason to leave the warp platform and explore the planet. Loot Chests randomly spawn with random goodies in them.
* **(DONE)** Warp Nukes
* **(DONE)** Wait for community playtesting. Monitor for approx 1 week for bug reports and suggestions.
* **(DONE)** Playtest and balance things and hunt and fix bugs (finished red and green science)
* **(DONE)** Fix bugs ghost-entity directions being lost between warps
* **(DONE)** Final Checks
* **(DONE)** Release
* **(DONE)** Mic Drop

---

Features and bugs and things i will not be adding or addressing for various reasons:

* Boss biters, more biter types, levels, and sizes.
* Biter kill counter
* Bookmarking planets.
* Infinite platform sizes.
* Additional floors: Teleporter Room (a small intermediary between teleporter gate and platform).
* Special/dedicated/upgradeable platform defences, or other kinds of special platform structures aside from those that affect logistics.
* A mass recall ability (to automatically deconstruct everything you've built outside the platform).
* Circuit network through planet teleporter. Making this happen requires a glitchy use of factorio surfaces.
* Fix bugs persistence of circuit connections of underground entrances to platform entities between upgrades.
* Further mod compatability
* Mod Achievements
* Unidirectional pipes waste their contents when the destination pipe has a reserved fluid in it, and they also waste their contents between upgrades. Instead, their capacity was reduced to 500.
* Difficulty, pollution & general mod settings. Instead, most settings for planets are copied off the original map generation settings.
* Larger platforms will frequently cover spawn area resources. This is a problem. todo; make spawn area bigger. ... Apparently nothing can be done about this, as far as i know. Consider it an increase in difficulty in exchange for bigger platform.
* Loader filters are lost when switching loader directions and they also lose items on the loaders.

---
**peacekeeper03:** Nice. Looking forwad for updates an a test.
Love this mod too

---
**Kythblood:** Thanks.
I'm not sure what your plans for the Warp Stabilizer are, but in case you don't make any big changes to it I would appreciate it you could add a button similar to the warp button to reset pollution. Having to unplug it from the network and power it again after each warp is just annoying.

---
**PyroFire (op):** > Thanks.
> I'm not sure what your plans for the Warp Stabilizer are, but in case you don't make any big changes to it I would appreciate it you could add a button similar to the warp button to reset pollution. Having to unplug it from the network and power it again after each warp just annoying.

Haven't fully decided what it should be, but yeah i was thinking about making it a button.
It's fairly easy to use the power in the underground entrances as your "platform power" for use, because one thing's for certain - an accumulator is just awkward to use. You have no reliable way to control it.
We'll see what happens, but for now i want just the basics done.

---
**unhott:** You could probably give the accumulator a custom GUI with a button to discharge pollution that consumes x joules of energy. Entity custom GUI isn’t something I’ve done before but it comes up a lot.

---
**unhott:** If NONOCE is willing they can add you as a contributor to be able to update this mod. And if the source code goes on github I’d be happy to contribute what I can.

---
**PyroFire (op):** > You could probably give the accumulator a custom GUI with a button to discharge pollution that consumes x joules of energy. Entity custom GUI isn’t something I’ve done before but it comes up a lot.

The problem with accumulators is they have energy rate limits.
This is controlled by the placement of power poles.
To describe this simply, Accumulators are just awkward to control.
For now, you can upgrade the underground entrances, which are accumulators.
I can then interface with these in lua for multiple platform abilities.
For example, i was thinking about adding a pocket dimension for mining, but is only open temporarily and requires some platform power.

> If NONOCE is willing they can add you as a contributor to be able to update this mod. And if the source code goes on github I’d be happy to contribute what I can.

This would be good, so people don't need to update links.
Not sure what to do about the migration though.

Also;
<https://github.com/PyroFire232/warptorio2>

---
**The_Fong:** I'm trying to play test your mod but getting errors from the technology prerequisites.

---
**PyroFire (op):** > I'm trying to play test your mod but getting errors from the technology prerequisites.

If it doesn't work when you try it, wait for some files to change and try again.
I'm generally updating it as i go.

Also, rip old saves. You're welcome to try your hand at writing the migration script when i'm done.
It'll be worth it though, and i doubt anyone is too much further than a few days because of how limited the platform is.

Also, apparently posts have a 10,000 character limit.

* Edit: I ended up writing a migration script.

---
**The_Fong:** I'll check back later. Thank you to you and Nonoce for working on the mod! The Factorio modding community continually amazes me.

---
**PyroFire (op):** OP Delivers.

![](https://assets-mod.factorio.com/assets/ext/6df0c878ee37ce8bd097824eef27c2367bf00bd0e78e92c2dcf08324bd8bd0e3.gif)
