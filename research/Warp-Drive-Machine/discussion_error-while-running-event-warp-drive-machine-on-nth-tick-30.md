# Error while running event Warp-Drive-Machine::on_nth_tick(30)

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68a4caf4912d042b03f68f89
- Thread ID: 68a4caf4912d042b03f68f89
- Started by: TechieNeko

---
**TechieNeko (op):** FYI, have quite a few QoL mods added to my save, not sure on the easiest way to post them without my entire Mod list just printed in text here...
Only just started this save, I'm just warping for the first time, and it errors just as timer hits 1 second (Before loading the new map)

The mod Warp Drive Machine (1.0.7) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:721: bad argument #3 of 3 to '**index' (string expected, got nil)
stack traceback:
[C]: in function '\_\_index'
\_\_Warp-Drive-Machine**/warp-control.lua:721: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:647: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:772: in function <**Warp-Drive-Machine**/control.lua:771>

---
**TechieNeko (op):** "mods":

"base”
“elevated-rails”
“quality”
“space-age”
“alien-biomes”
“alien-biomes-graphics”
“AutoDeconstruct”
“Cold\_biters”
“crafting-queue-enhancements”
“CursorEnhancements”
“DiscoScience”
“even-distribution”
“Explosive\_biters”
“factorio-crash-site”
“Fill4Me”
“FilterChests”
“Fireproof-Bots-2”
“flib”
“inventory-repair”
“k2-fluid-storage”
“LongInserters”
“mferrari\_lib”
“mining-patch-planner”
“PowerPole32”
“pump”
“RateCalculator”
“squeak-through-2”
“StatsGui”
“Toxic\_biters”
“turret-activation-delay”
“visible-planets”
“Warehousing”
“Warp-Drive-Machine"

---
**TechieNeko (op):** Checked Discord, was reported there a few hours prior and is now Fixed in 1.0.8
