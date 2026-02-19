# Harvester Chest Missing

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6285afadd9171017628cb634
- Thread ID: 6285afadd9171017628cb634
- Started by: mcbaine2

---
**mcbaine2 (op):** None of my harvesters ever spawn with chests, all other warp platforms have chests with loaders. I was also having the previously reported issue of the blue underground pipes missing but was able to fix that with the suggested code change in the harvester config file. I can't find anywhere in the file where it calls for the chest to be created so I am not sure how I can spawn that in as it's supposed to be.

<https://imgur.com/a/mT8Ai3g>

---
**DestinyAtlantis:** The harvesters don't have chests in the first place. they directly teleport resources from loader to loader, unlike the stair ones that have chests acting like buffers. Agreed on the weirdly spawning pipes and loaders. It "might" be fixeable if you return the platforms, then pick up a new copy? not 100% sure.
It does fix itself on next warp.

Basically you are meant to directly smelt the stuff, or store them on the platforms, warehouse/merge chest mod helps a lot.

---
**PyroFire (mod author):** There are no chests which spawn with the harvesters, instead they just have straight loaders and pipes.
Spawning of these was bug.
It is fix now in 1.3.9
