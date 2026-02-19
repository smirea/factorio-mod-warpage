# Mining Drones integration

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/65f549885600bec389a6ba00
- Thread ID: 65f549885600bec389a6ba00
- Started by: AivanF

---
**AivanF (op):** Hi! Personally I haven't tried your mod, but a couple of times a got feature request to add compatibility for MD2R with your mod.

Because of similar requests, I already added compatibility with Warptorio2 which seems quite similar. Actually, it required small amount of changes, mainly to make special entities (like invisible walls, power connectors, mining drones themselves) ignored during platforms teleportations using special W2 remote interface function. [Here is the diff on GitHub](https://github.com/AivanF/factorio-Mining-Drones-Remastered/commit/e261a3ed13ad38c3f98626d9ef4732b98c716641#diff-4121c36148b4e8ef5f7cae61402138d2e237b47700e74b9df17aac358d70e101R1585). Then the teleportation event is handled (not the event from W2, but special parameters set of `on_built_entity` game event) to clean old entities; and I hope this event will be simply reused with your mod, so that only blacklisting is required. Meanwhile, I found no similar possibility in the source code of WDM.

So here is a question: do you plan to add a similar remote interfaces (blacklisting some entities from teleporting them, and maybe subscription to teleportation events) for other mods to integrate? IMHO, such functionality is an important step for any overhaul mod to grow mature `:)`

---
**AivanF (op):** And yeah, forgot to mention a link to Mining Drones 2 in case you haven't seen it: <https://mods.factorio.com/mod/Mining_Drones_Remastered>

---
**MFerrari (mod author):** Hi friend.
Take a look on the event <https://lua-api.factorio.com/latest/events.html#on_entity_cloned>
There your mod can handle everything about your own mod. Exactly what you asked here. Destroy old invisible entitties while creating the new required ones on the new cloned area.
You could write a single solution for all cloning mods, like W2 or WDM. I think there is no need to handle each mod separately. I've made this on many mods of my own, when Pyrofire inventeda that crazy warp machine, with cloning entities on other surfaces... =)
Or is there any impossibility on your side ? We can discuss this further if necessary

---
**AivanF (op):** Well, this event is already used to properly delete additional invisible entities of cloned source. But, taking into account players feedback, I suppose that WDM creates clones of these invisible entities before they got deleted, and because of being created by external code, these new invisible instances get not managed by the code of my mod. Therefore, cloning blacklisting by entity names list, like in W2, still seems to be needed `:)`

---
**MFerrari (mod author):** I use surface.clone\_brush, that clones everything in an area... There is no filter on that
The game engine raises defines.events.on\_entity\_cloned for each entity, and then defines.events.on\_area\_cloned is raised. Thats why each mod should define what to do when it happens
