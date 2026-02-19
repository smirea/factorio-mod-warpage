# Game crashes when warping to a planet with no water.

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68a32022a86e2ca3d73388a7
- Thread ID: 68a32022a86e2ca3d73388a7
- Started by: Zeritor

---
**Zeritor (op):** V 1.0.4, warp-control.lua line 297, tries to access index "water" on a nil object (the map\_gen\_settings)

We took a look at the diff for 1.0.5 and don't think it's fixed there.

I think it's because we DID NOT have Space Age enabled, as the code for managing the default map\_gen\_settings varies based on the presence of that.

---
**MFerrari (mod author):** fixing
