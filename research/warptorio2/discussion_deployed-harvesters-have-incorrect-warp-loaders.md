# Deployed Harvesters have Incorrect Warp Loaders

- URL: https://mods.factorio.com/mod/warptorio2/discussion/62336b0ed2d76103fd8ba4cf
- Thread ID: 62336b0ed2d76103fd8ba4cf
- Started by: Pumafgt

---
**Pumafgt (op):** Hello there! I'm very much enjoying this mod. :)

Recently I researched the technology that allows Harvesters to have a second Warp Loader (Warp Platform Logistics Dual Loader 1). My left Harvester did not receive the extra Warp Loader, while my right Harvester did. I've attached a screenshot to show the difference.

<https://imgur.com/a/F78IlSB>

Edit: I did a little experimentation after noticing the warp loader and a few pipes sitting out in the middle of nowhere in the wild. In general, I would always go collect my harvesters before warping away, thereby having its spawner in my inventory post warp. I instead let my harvesters expire on the planet and be automatically recalled when I warped. This resolved the issue.

---
**thuejk:** The warp loaders use the same logic as the warp pipes, so the patch I posted in the other thread will automatically also fix this.

---
**PyroFire (mod author):** It is unwise for players to alter the mod themselves because it can lead to save corruption and mod version conflicts, even for small changes.
But yeah this almost a duplicate of <https://mods.factorio.com/mod/warptorio2/discussion/6227478a56482aa5e00be716> except this contains steps to reproduce the issue.

---
**overcl0ck:** is this not patched yet? my pipes are not on my harvester platform, they just hang alone on east and west side of the warp platform

---
**thuejk:** I posted a patch in the other thread, and PyroFire seemed to say that my fix was correct. And there have been new releases since then. But the fix does not seem to be mentioned in the changelog, or to be in the code? So apparently not patched yet.

---
**Quaitgor:** I have the same problem with one harvester completly missing pipes, the other having them in a weird position. I write in this thread/discussion to bump the thread, hopping that the mention fix gets added and solves my problem too

---
**PyroFire (mod author):** Fix in 1.3.9
