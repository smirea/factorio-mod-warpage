# Great mod, has some bugs/issues.

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/64bd4afc96095eea201bb990
- Thread ID: 64bd4afc96095eea201bb990
- Started by: KonekoKeru

---
**KonekoKeru (op):** I'm using a combination of mods (mainly a good chunk of bob's mods, bio industries, stacking beltboxes, and a lot of QOL) and most things seem to work pretty okay!
Onto the issues I've had;

* The very first warp seems to always kill me despite being on the platform; I'm unsure if this is caused by any of the mods I'm using, there doesn't seem to be anything that modifies the player in any way. I've even removed Squeak Through, but that doesn't seem to be the problem. The issue only happens on first warp, though it appears to work completely fine after that.
  Edit: Issue seems to constantly happen if I use a mod like Bob's classes.
* Some modded structures don't stay on the Everything tiles; for example, using the mod "Stone Water Well," despite ensuring it's 100% on the green tile, this thing always gets removed, in and out of warping. I'm sure other mods will face similar issues, i.e. I'm concerned if this will interfere with Bio Industries' terraformer.
  Edit: Looks like anything relating to a water pump just can't stay on the ship in general. A bit of an odd design choice, any chance for a config? Or a research to place a water source on one of the floors?
* Issue with Bottleneck; the icons used to indicate if a machine is working, idle, slowed, etc- get removed off of a machine upon warping, and remain that way unless they're manually replaced. Seems the mod also generally just stops all the animations of entities on board.
* Gerkiz's RPG mod; opening the UI element for this mod hides the ship and planet info buttons. For the moment not using the RPG mod.

Beyond that, this is an excellent start to the mod, it works a lot better than expected despite some of these little quirks!

---
**MFerrari (mod author):** > * The very first warp seems to always kill me despite being on the platform; I'm unsure if this is caused by any of the mods I'm using, there doesn't seem to be anything that modifies the player in any way. I've even removed Squeak Through, but that doesn't seem to be the problem. The issue only happens on first warp, though it appears to work completely fine after that.
>   I have no idea why... or maybe I have: characters cloned gets duplicated, and I have to destroy the cloned one.
> * Some modded structures don't stay on the Everything tiles; for example, using the mod "Stone Water Well," despite ensuring it's 100% on the green tile, this thing always gets removed, in and out of warping. I'm sure other mods will face similar issues, i.e. I'm concerned if this will interfere with Bio Industries' terraformer.
>   Water pumps are always removed. Its weird if they stay on the ship and then keeps generating water on next planet, even if there is no water.
>   Added a interface for modded names: `/c remote.call("WDM", "add_exception_do_not_destroy_on_warp", entity_name)`
> * Issue with Bottleneck; the icons used to indicate if a machine is working, idle, slowed, etc- get removed off of a machine upon warping, and remain that way unless they're manually replaced. Seems the mod also generally just stops all the animations of entities on board.
>   Looks like the mod does not suppor cloned entities
> * Gerkiz's RPG mod; opening the UI element for this mod hides the ship and planet info buttons. For the moment not using the RPG mod.
>   May its not compatible then. The mod should not destroy other mods guis
>
> Beyond that, this is an excellent start to the mod, it works a lot better than expected despite some of these little quirks!
> Thanks! =)

---
**TSP:** If you guys'd like, I can directly contact Gerkiz if the mod issue is on his side instead of Warp Drive Machine?

---
**KonekoKeru (op):** Oh, completely forgot about this post.

Another issue came up: some weird compatibility issues with Dectorio, allowing me to remove and replace ship floor with no issues, and the flooring gets changed to colored concrete (which still functions like ship flooring.)
Definitely a little cheaty, especially with green concrete being easier to make than the 'anything' ship floor.

I also did have a question; is there plans for more configs similar to what warptorio has? Like more difficulty adjustments and such?

---
**MFerrari (mod author):** Then, Dectorio is now incompatible.
The mod has already some settings for difficulty. I may add more specific ones later if necessary

---
**Tirus:** I started to play this mod with some friends in the multiplayer. Here are some issues we found until now:
- Staying inside a Vehicle while on the platform is a bad idea -> you will be left behind
- Placing ground tiles in the lower decks while running can kill you (when you run or stay on the corner)
- Staying on a warp insured area while warping will left you behind (the area will be warped inside the ship, but you will stay where you are and left behind)
- Getting killed inside a cave crashes the game because no spawn location can be found
- Getting killed in the Warp insured room will also crash the game because no spawn location can be found

Beside that, its a very cool mod. Very similar to "Warptorio 2" but the ground tile restriction has some interesting aspects :).
