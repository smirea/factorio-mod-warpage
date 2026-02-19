# Warp pipes not present in deplayed harvesters

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6227478a56482aa5e00be716
- Thread ID: 6227478a56482aa5e00be716
- Started by: thuejk

---
**thuejk (op):** So I upgraded to the 1 hour old Warptorio2, and found a bug I think. When I deploy a warp harvester, the warp harvester pipes are not present on the deployed platform. Instead the pipes appear isolated at the surface near the base, probably at the same (x,y) position they were underground.

This is with Warptorio2 Expansion installed, but I assume that this bug is part of the base game.

A save of the game showing the bug is at <https://thuejk.dk/antievent.zip>

Video of the bug: <https://www.youtube.com/watch?v=zcfbShsIA2E>

---
**PyroFire (mod author):** That's weird. i doubt it was added in the latest version though.

---
**thuejk (op):** So after some testing, this is a warptorio2 bug, happens without warptorio2 expansion.

After some more testing, this happens on experimental Factorio 1.1.55, and not on stable Factorio 1.1.53. The bug happens both on Warptorio 1.35 and 1.36. (Planetorio crashes on experimental Factorio 1.1.56 for what is probably a separate reason, which I have reported to the Factorio devs separately, but feel free to look into that too.)

---
**PyroFire (mod author):** Planetorio crash is probably the missing planet template bug <https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68>

Could you link your bug report forum thread here so I can review if it has useful information in it and provide confirmation if it is an issue with base factorio or just the mod?

---
**thuejk (op):** The 1.1.56 planetorio thing will be fixed in the next release: <https://mods.factorio.com/mod/planetorio/discussion/62297cdffcd8be5264cddca3> . Was an issue with base Factorio.

---
**thuejk (op):** So I found the bug in the code. In HARV:CheckPointLogistics , it is using .position instead of .deploy\_position, even if the harvester is deployed.

The fix is the following code:

```
if(i==2 and self.deployed)then
       pos = self.deploy_position
       f=global.floor.main.host
    end
```

The reason why this did not always break the mod is that sometime the pipes succeeds at is\_valid(), and the pipes are not rebuild.

CheckPointLogistics also used the same code for the belt position, which was also sometimes misplaced.

---
**Pumafgt:** I'm also having this issue, but it's happening to me on 1.1.53. Is there a way to implement the code you've provided locally, thuejk?

---
**thuejk (op):** Yes. just unpack the mod in the mod directory, and Factorio will still run it.

The edit it to replace line 221 with the code I posted. <https://github.com/PyroFire232/warptorio2/blob/master/control_class_harvester.lua#L221>

---
**Pumafgt:** Thank you very much! :)

---
**Supaplex.:** @pyrofire - is it possible to update the mod?
Playing multiplayer is a problem despite manual script update

---
**PyroFire (mod author):** It is usually unwise to manually change the mod because it can lead to save corruption and mod version conflicts, even for small changes.
Steps to reproduce this issue were reported in another thread: <https://mods.factorio.com/mod/warptorio2/discussion/62336b0ed2d76103fd8ba4cf>
Namely, deploy a harvester and then get a logistics upgrade which adds or changes the belt. This sets up a glitched state for the harvesters which is seemingly never corrected.
It does indeed seem to be coming from the wrong position being used in <https://github.com/PyroFire232/warptorio2/blob/master/control_class_harvester.lua#L221> like suggested.

---
**Darkenlord1:** If it was fixed, then not much, still getting this issue, pipes spawning near base in fixed position when placing harvesters (both).

---
**jnf27170:** Same here. I started 2 fresh games of warptorio without additional mod. In these 2 games, I have the issue of pipes of harvester platform not being placed with the mobile platform but being placed at the x and y position above the underground initial position of the platform.

---
**jnf27170:** I continued the game and reached the second loader on the harvester platforms, and this second loader has the same bug as the 2 pipes.
This was done with the last version 1.3.8 of warptorio.
Luckily, I had the version 1.3.5 installed from previous game of warptorio. The mod manager let me use this old version, I did it with my actual save game (by-passing the warning of old mod) and everything is working correctly now.
So, the bug may appear between 1.3.6 and 1.3.8, and, by reading the changelog, I am quite sure that this bug came with the 1.3.6 version.

---
**PyroFire (mod author):** fix as of 1.3.9
