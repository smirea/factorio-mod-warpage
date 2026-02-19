# Is 40h in no cave warp normal?

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68acc819802e57c050468612
- Thread ID: 68acc819802e57c050468612
- Started by: NeoChaos12

---
**NeoChaos12 (op):** I've realized while reading some posts here that it is possible for the platform to warp inside a cave. This would answer some of my gripes about warponium in a different post (though not all) but the question is, how frequent is that event? I've got nearly 40h of playtime across two runs on this mod and this hasn't happened to me even once! Is this expected behaviour or a bug?
(I'm using all the recommended mods for WDM-SA (no K2) as well as Editor Extensions (haven't actually used it yet), rate calculator, FNEI and a UI mod for a real world clock in-game)

---
**EnaidGollwyd:** Have you tried to explore the sorroundings with a car? Caves are very rare for me as well, I've only seen 2 but they're far away from the ship.

---
**NeoChaos12 (op):** Yeah I've run into many cave entrances, but I'm referring to the specific event where the space platform itself warps inside a cave. That would be a great and possibly only real opportunity to gather some warponium before unlocking the warp power tower.

---
**Ranec2:** I forget the specific meanings below but it will not happen until certain criteria are met, like a tech and some number of warps. This is in the control.lua file in this mod:

["underground\_warp"] = {chance=0.07, min\_wap=25, min\_tech\_progress=0.12, exclusive=true, warn\_crew=true, alarm=true, no\_repeat=true, must\_have\_on=20 },

You can get warptoniom from old ships you find on the surface of like 20٪ of the planets. They usually have a few thousand ore of a few resources. This is enough for the early game fixes I find.
