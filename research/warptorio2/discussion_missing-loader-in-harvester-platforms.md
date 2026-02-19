# Missing loader in harvester platforms

- URL: https://mods.factorio.com/mod/warptorio2/discussion/62828021dd1d2620a3bae178
- Thread ID: 62828021dd1d2620a3bae178
- Started by: wladekb

---
**wladekb (op):** At the moment I don't have loaders in harvester platforms that get teleported to the surface (the corresponding loaders underground are fine). They simply disappeared within the last hour of my game, and I didn't noticed it when it happened.

I can't find a way to get them respawned.

I'm also unsure what exactly caused that.

<https://imgur.com/a/MLiJ09t>

How can I get them back in order to continue my gameplay?

---
**wladekb (op):** I needed to execute this to fix it, but it should not happen in the first place I guess.

`/c __warptorio2__ global.Harvesters['west']:RunUpgrade()`

---
**wladekb (op):** I stumbled upon another issue after resolving this special blue pipes that should be placed within the harvester platform on the surface are instead always placed at the same offset as in the underground. Looks like the offset for the harvester platform on the surface is not added.

---
**Darkenlord1:** Same issue, but pipes appearing only after placing harvester teleporter:
<https://imgur.com/Puf5NIA>
<https://imgur.com/q3FcPZI>

and command above helps to fix this too.

---
**PyroFire (mod author):** fix in 1.3.9
