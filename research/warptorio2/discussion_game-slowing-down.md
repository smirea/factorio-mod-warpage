# Game slowing down

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5e9a72a6d452c2000f1e43cc
- Thread ID: 5e9a72a6d452c2000f1e43cc
- Started by: Sciencefreak

---
**Sciencefreak (op):** Especially the saving gets really slow. The reason seems to be, that you keep all layers. What is the point in keeping the first Warpzone if you are in Warpzone 30? Is there any point to keep all of them? They do not only occupy memory space, but all stuff is still running (biters etc).

---
**Sciencefreak (op):** Used the editor to delete all warpzones from 2 (keept number 1 in case there is something special) to current zone-1 and save game size dropped by a factor of 6 and time to save even more

---
**PyroFire (mod author):** > The reason seems to be, that you keep all layers.

The mod is intended to destroy any/all abandoned surfaces.
You're suggesting that this isn't working.

Please ensure you're on the latest version of the mod.

---
**Sciencefreak (op):** I used the version 1.26, which was the most up to date version when I wrote the message. No idea, why it was not working. I only used FNEI as another mod, which does not alter any surfaces

---
**PyroFire (mod author):** It's more likely the surface cleaning is actually broken, so i'll have to look into this.

---
**PyroFire (mod author):** Fixxed. Note this fix also automatically cleans up after itself so any abandoned surfaces will be destroyed after your next warp.

---
**supernet2:** I had this same issue. Wait we can't revisit old worlds? They don't get archived?

---
**PyroFire (mod author):** > I had this same issue. Wait we can't revisit old worlds? They don't get archived?

All destroyed, or your save would be 30gig or more.
Only homeworld and nauvis.

---
**ksharenkov:** It seems that slowdown appears after "choose planet" researched and used (not sure)

---
**Kythblood:** Is there a command that lets me clear all old worlds manually?

I also noticed that my autosaves are slowing down (a few seconds) and looked at my save files.
My 20h Warptorio2 save is 3 times the size of my 210h Krastorio+SpaceE save.
I am playing on version 1.2.8 and with the Warptorio2 Expansion 0.18.57.

---
**PyroFire (mod author):** You can check if the old surfaces are still there by using /editor.
