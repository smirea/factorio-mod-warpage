# Bug : Same seed on Fulgora/Vulcanus

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/68a776e52b053f3d07f197f3
- Thread ID: 68a776e52b053f3d07f197f3
- Started by: Mitrano

---
**Mitrano (op):** On Fulgora and Vulcanus, we experience warping at the exact same seed for ~20 warps, we didn't manage to get new seeds of these two planets.
Same placement of resources, same cliffs, when we warp back to back on those planet, our constructions/fog of war discoveries stays, but when "a new planet" is generated, the exact same seed is used.

P.S : I love this mod, thank you for your work :)

---
**Venca123 (mod author):** I will add check to make sure you always get new seed

---
**ZombieDenden:** Im getting the same between Nauvis and Vulcanis.

And the Nauvis one says "Something is not right here"

---
**vankuih:** i think there might be some surface creation/clearing issue, I edited rng on variants so it doesn't repeat until all are used (I don't think that seeds will repeat as it is 0 to 2^16) but still get same fulgora and vulcanus (didn't check for gleba and aquilo), even buildings built by me are still here

---
**Venca123 (mod author):** I added message to when this is happening with explanation why as well in 0.2.9
