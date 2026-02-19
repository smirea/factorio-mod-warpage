# Slowdowns

- URL: https://mods.factorio.com/mod/warptorio/discussion/5ce49c2fc83fea000cf142d2
- Thread ID: 5ce49c2fc83fea000cf142d2
- Started by: Disferente

---
**Disferente (op):** After a couple of warps my ups always goes down to around 30, so I though of a possible fix for it, though I don't know how viable it is or why you do the mod the way you do.
So anyway, is there any particular reason that you create a new surface for every warp instead of just deleting the chunks outside of the warp platform and generating the terrain anew?

---
**ElizTriad:** Good idea, since after the warp the previous location continues to exist. All entities and buildings also continue to work. This creates a huge load even on powerful computers.

---
**Disferente (op):** That would also fix that composite buildings like the Burner turbine generator of AAI Industry stop working after warp, having to remove and replace them to get them working again.

---
**NONOCE (mod author):** I think the terrain would be the same if I deleted it then regenerated it because the generator seed would stays the same. Anyway the mod should delete surfaces where no players are present normaly after a warp to save memory and performance but it's possible there are still bugs when it do so, I will try to look at it.

---
**Disferente (op):** You can change the map seed with:

local surface = game.player.surface
local mgs = surface.map\_gen\_settings
mgs.seed=12345678
surface.map\_gen\_settings = mgs
game.player.print(game.player.surface.map\_gen\_settings.seed)
