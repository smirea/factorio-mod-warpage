# Teleported out of spidertron when crossing stairs.

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5f56e4482081f8a3d9cec793
- Thread ID: 5f56e4482081f8a3d9cec793
- Started by: mrudat

---
**mrudat (op):** If you drive a spidertron over any of the stairs, you get teleported out of the spidertron, which is unexpected.

However, this is actually the desired behaviour if you're using [Spidertron Engineer](https://mods.factorio.com/mod/SpidertronEngineer/discussion/5f3c7b7ca3d6ccfb8ccabc43), as the spidertron will follow the character.

---
**PyroFire (mod author):** Partially a bug.
I'd prefer to teleport the spider with the player, but meh coding it...

---
**PyroFire (mod author):** Added to list of flaws.

---
**PyroFire (mod author):** Seems like this isn't an issue anymore, but using .teleport (preferred) instead of cloning (current implementation) has weird results: <https://gyazo.com/b5cd3c5a4eb9c7f5345d7ebc22cfbe76>. If there are still issues here please post a new thread.
