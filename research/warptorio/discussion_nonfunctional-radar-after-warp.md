# Nonfunctional radar after warp

- URL: https://mods.factorio.com/mod/warptorio/discussion/5ce565b9eaf520000d948502
- Thread ID: 5ce565b9eaf520000d948502
- Started by: Ferlonas

---
**Ferlonas (op):** This might be related to the mod Big Brother that I have also installed, but after a warp, my radar gets "replaced" by a non-functional radar that I can not mine nor destroy.
After getting rid of it with "/c game.player.selected.destroy()", the radar I previously placed appears there again and works fine.

---
**NONOCE (mod author):** The mod uses the game clone function to copy the platform to an other surface when it warps. I guess if another mod uses entities in a non standard way the cloning may not works correctly. It might be possible to fix it but I will not be working on mod compatibility for now.
