# Patch to change default provider chest

- URL: https://mods.factorio.com/mod/warptorio2/discussion/622fc5a2f4fae9ab7a46da0e
- Thread ID: 622fc5a2f4fae9ab7a46da0e
- Started by: thuejk

---
**thuejk (op):** Having logistics bots put everything into storage chests really, really breaks everything. The default between floors chest should be a passive provider.

diff -Nur warptorio2\_1.3.6/settings.lua warptorio2\_1.3.6\_new/settings.lua
--- warptorio2\_1.3.6/settings.lua 2020-08-02 16:48:14.000000000 +0200
+++ warptorio2\_1.3.6\_new/settings.lua 2022-03-14 23:42:04.800000320 +0100
@@ -23,7 +23,7 @@
allowed\_values={"up","down"}},

```
{type="string-setting", name="warptorio_loaderchest_provider",order="aaac",
```

* setting\_type="runtime-global", default\_value="logistic-chest-active-provider",
* setting\_type="runtime-global", default\_value="logistic-chest-passive-provider",
  allowed\_values={"logistic-chest-active-provider","logistic-chest-buffer","logistic-chest-passive-provider","logistic-chest-storage","steel-chest"},
  },

---
**PyroFire (mod author):** In brief, there are arguments to be made in favor of any of the logistics chests being used by default.
Why not the buffer chest?

A passive provider is unlikely to be emptied fully and firstly if you had other provider chests on the same floor with buffered resources.
It is better to empty the chests attached to the loaders first over emptying local storage first as this allows a higher throughput between each floor: your inflow of resources is not slowed down because of the competition with storage chests and other passive provider chests, therefore, the default chest should be an active provider.

This is why it's a setting: there are pros and cons to each type of chest, but active providers are the most ideal.

---
**thuejk (op):** > Why not the buffer chest?

Because then bots will put stuff in it, which will pollute the loader belts.

And as I said, having it be an active provider will make it impossible to storage chests and logistics bots on the floor. Which is really game-breaking.

You can always get the active provider chest effect by simply placing a stack inserter into an active provider on the other side of the loader. moving chest->chest, a single fully upgraded stack inserter is almost as fast as a blue belt. Hence making the default a passive provider does not take away this option.

It is fairly hard to change the chest type from an active provider once it has been placed, almost game-breaking, so it is absolutely not ideal to have this be the default.

---
**RRRRIP:** Yeah... just upgraded to warp logistics 4 and the active provider chests ruined my base. Just one example: I was making artillery shells on the factory floor and sending them down to the harvester floor, where I was putting them into a passive provider chest. These chests were providing the shells to two requester chests on the platforms, so I could have artillery on the platforms to clear out the area wherever I placed the platform. Well, when they turned into active provider chests, that tied up all of my logistics robots who were trying to send them to the one storage chest I put down there, which filled up pretty quickly, so it stopped working completely. Plus, that started eating up my resources again, since the chest was empty and the factory started making artillery shells nonstop.

There really needs to be an option to switch the chests after you upgrade. I would have been totally fine if they were passive provider chests. Just let me click on them, or right click on them, or click on the stairs or something, and switch the chest type.

---
**splee:** The tech description should probably also do a better job of detailing the kind of chest upgrade that's about to happen. Knowing what is coming & simply choosing not to research it, would likely avert a bunch of "why this happen to my base?" complaints.

---
**NIKITAzed:** had the same annoyance as soon as I got the research, glad to see that it is a changeable setting after reading though

---
**PyroFire (mod author):** Added to 1.3.11 due to popular demand
