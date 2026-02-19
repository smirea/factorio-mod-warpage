# Kill biters for resources

- URL: https://mods.factorio.com/mod/warptorio2/discussion/66944a203e37fa57e56d0d92
- Thread ID: 66944a203e37fa57e56d0d92
- Started by: FancyMoses

---
**FancyMoses (op):** I have been playing a run with the "Kill biters for resources" mod and the only planet that works with them is the uncharted planet.
I tried changing the weight in the startup settings so that uncharted comes up more often but it's not working and I am still getting all the other planets that have been set to 0 while Uncharted I've ramped up to 9999.

I've gone into the planetorio settings to try and set the planets to be copies of Nauvis as well "copy\_nauvis" - but I don't think I'm doing it correctly because even planets I delete from the "control\_planets\_templates.lua" and the "settings.lua" come up on the next warp...

Would love to be able to play Warptorio with my platform as a fortress that kills attacking biters for me to collect resources.

Summary: How can I get the Kill biters for resources mod to work with warptorio OR modify the planets so I don't get stuck waiting on empty planets for my next warp.

---
**PyroFire (mod author):** Planet templates are cached in the save file, that's probably why you were experiencing problems even after deleting templates from the planetorio lua files.
Similarly, the startup settings for each planet correspond to their warp zone (how late or early in a playthrough the planet will start appearing), not their chance of appearance.

Regarding the "Kill biters for resources" mod related issues, that sounds like a mod compatibility issue.
This is the first report of this kind related to that particular mod.
Investigation needed.
