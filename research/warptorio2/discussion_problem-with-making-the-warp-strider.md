# Problem with making the warp strider

- URL: https://mods.factorio.com/mod/warptorio2/discussion/64c78fcef84bedea2f85f7f2
- Thread ID: 64c78fcef84bedea2f85f7f2
- Started by: TheXtremeKing

---
**TheXtremeKing (op):** I can't insert more than 1 Mk2 power armor in the assembly machine and there are 8 needed. All other ingredients do work.

---
**exfret:** Maybe take equipment out if there's any in it?

---
**exfret:** Actually even that won't work, it's simply not stackable. Not sure why it's required to have 8

---
**TheXtremeKing (op):** So same for you? I also can't make the warp armor because of this

---
**Unfizzy:** Giving this another bump, as I have run into this problem too now.

Though it is fine for the spidertron and satellite requirements, even though they have a stack size of one, so hopefully it can be updated for this ingredient also

Cheers

---
**TheXtremeKing (op):** I wanted to try them out / easy fix the problem, so I changed the recipes in the mod. How to do this yourself:

-goto %Appdata%/Factorio/mods
-unzip warptorio2\_1.3.10.zip
-edit /prototypes/data\_warptorio-warpspider.lua >> search for: spider.recipe.ingredients and change nr of armors to 1
-edit /data\_warptorio.lua >> search for: {name="warptorio-armor",enabled=false,ingredients= and change all armors to 1
-now rezip and you're done :)

---
**Unfizzy:** Thank you TheXtremeKing, for the nice work around

---
**aliam13:** Hi,
Same issue here. But I also ran into the exact same issue creating the wrap armour in an assembly machine.
Thanks.

---
**PyroFire (mod author):** Lost armor inserts being lost on crafting upgrades is working as intended.
That is, it is intended that crafting a thing with 1 or more power armors as the recipe, even if those ingredients take up an entire inventory slot on their own, is working as intended, however I do not believe that base factorio took into account the situation where you craft a recipe using a modular armor (or more than one) which had items inserted into them (like batteries, shields, roboports etc) and to refund/replace/inventory/deal-with those module pieces. This is probably one more for wube than for warptorio specifically.
