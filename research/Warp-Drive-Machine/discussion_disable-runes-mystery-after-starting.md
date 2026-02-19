# Disable Runes Mystery After Starting?

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/67ffbaaee9f954a3efd3edee
- Thread ID: 67ffbaaee9f954a3efd3edee
- Started by: PlzPuddngPlz

---
**PlzPuddngPlz (op):** Hey - been enjoying my playthrough a lot. Big fan of the creativity and variation in planets, and the cave exploration is really cool. I'm more or less ready to finish the ship now, but only have a few of the ancient runes and don't really want to planet hop hoping for space stations for the rest. After looking through mod options it looks like there's an option to turn off the puzzle. It doesn't seem to unlock the research when I toggle it.

Can it only be set when starting a new save? If so, a tooltip indicating that would be useful since it's ambiguous currently.

Tried:
-Toggling off the "Enable ancient ruins mystery" option in mod settings
-Toggling the option off from the main menu and reloading
-Turning the option off and loading from an earlier save before I finished the warp drive 9 research
The locked ancient rune puzzle research was still blocking the finish the ship research afterwards.

Expected behaviour:
Turning the option off should unlock the finish the ship research.

---
**PlzPuddngPlz (op):** For anyone with the same issue - I was able to force research with the command below, will disable achievements (in-game, steam will be disabled anyways due to the mod).

game.player.force.technologies[wdm\_ship\_fix\_lock].researched=true
