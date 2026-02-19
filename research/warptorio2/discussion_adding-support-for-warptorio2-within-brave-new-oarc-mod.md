# Adding support for Warptorio2 within Brave New Oarc mod

- URL: https://mods.factorio.com/mod/warptorio2/discussion/668c3cc14a55729f12d3c9fb
- Thread ID: 668c3cc14a55729f12d3c9fb
- Started by: JustGoFly

---
**JustGoFly (op):** Pyro - I love your mods! I would love to be able to run my Brave New Oarc mod with Warptorio2, and see all the remotes you provided. Can you provide some guidance on my making changes to BNO and remote calls to change Warptorio for:
1) size of starting pad, I need to load it up with entities including a special roboport that needs to teleport with the pad.
2) location of the teleport. BNO supports forces and multiple spawn locations - 0,0 is only the starting area, from which they spawn into a random location on each surface.
3) Each force would need their own warp clock, spawn location, and ability to warp whenever they want. This would mean some might be on warpzone\_1 while others have moved to warpzone\_2.

---
**PyroFire (mod author):** Hello, thank you for your feedback!

1) The size and shape of the starting platform is defined by platform\_classic.lua, unfortunately it cannot be controlled by remotes. Even this feature is also an unfinished work-in-progress, so to answer your question, this is not possible. If you would like to add entities to the platform initially, might I suggest starting with a scenario or using the /editor feature?
2) locations of teleports are hard-coded. if you would like to change a specific teleport of some kind, could you please specify which teleport you want to change?
3) Warptorio is not currently built for multiplayer (multiple forces). It has been suggested in the past and is very unlikely to be added.

I realize this probably isn't what you were hoping for, but please understand that maintaining mods isn't easy.
If you have further ideas or maybe you'd like to pitch in with development, you can always reach me on the warptorio2 discord.
