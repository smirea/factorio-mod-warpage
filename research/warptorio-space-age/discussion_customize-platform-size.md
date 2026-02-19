# Customize Platform Size

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/683da97e8530c95deb182e1d
- Thread ID: 683da97e8530c95deb182e1d
- Started by: Pasukaru

---
**Pasukaru (op):** Is there any way to increase the platform size? Unorthodox methods are fine.

Couldn't find anything in the options and I'm not sure what I need to look for when editing the mod files myself. Any help would be appreciated.

The reasoning: I also run Bobmods and with all the stuff that's required, platform is just too small even when cramming everything next to each other without inserters/belts and handfeeding everything.

---
**Venca123 (mod author):** Hello if you unpack the mod and look inside there is file called internal\_settings.lua this controls everything.

floor.levels - ground flour
factory.levels - factory floor
garden.levels - Garden floor

I am starting bobmods now as well to test them. So I will try to update things if needed once I know all the necessary numbers.

---
**Pasukaru (op):** Awesome! Thanks!

In the meantime I got Factorissimo working, that helps me a ton too.
I only removed it from the disallowed mods in the info file and had to exclude the factorissimo 'planets' in the roll\_planet function. Quick and dirty:

```
 if game.forces.player.is_space_location_unlocked(i) and not string.match(i, "[-]factory[-]floor") then
```

Works fine... So far - at least it has survived the first warp.

---
**Venca123 (mod author):** There are also issues with power in Factorissimo and I used to have few crashes as well, but maybe thinks are fixed now

---
**Pasukaru (op):** Yea factorissimo buildings don't get power when built in the lower floor. But on ground floor it works. Sometimes requires reconnecting the power poles after a warp.

There's also a problem in factorissimo that it doesn't detect the surfaces properly. When picking up a factorissimo building you can't place it anymore as it does some checks for surface name. I disabled those in their lua and now I can place them again.

So, a bit messy but works good enough for me.

I have also tried to increase the size via floor.levels as you mentioned. Doesn't seem to work on existing saves - or at least I couldn't get it to do anything.

---
**Venca123 (mod author):** it only checks those sizes then its performing the upgrade. If you have existing save you could "unresearch" current level of factory and then research it again

---
**Venca123 (mod author):** So far I did only quick test (Up to blue science) and it is possible to fit everything needed. It is definitely harder that vanilla, but possible. If you add any mod that adds 2x2 and 3x3 chests as well, then is easy to fit all that is needed

---
**fairyqueen:** This is a very helpful post. I'm also troubled by the insufficient space in the base. I like the biofuel power generation array of K2, but it requires a certain amount of space, which makes it impossible for me to place it. Now that the spatial structure has been expanded, it can finally be accommodated

---
**Venca123 (mod author):** In version 0.2.0 there are new factory size difficulties. Options are: SuperEasy, Easy, Normal, Hard, SuperHard
