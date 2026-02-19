# Fix players being able to cheese the mod by ignoring warp platform DEFENSE (and other observations)

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65a92733087062876500b4ed
- Thread ID: 65a92733087062876500b4ed
- Started by: mikehendi

---
**mikehendi (op):** Hi PyroFire, first of all, thanks for making a great mod, I'm having a lot of fun with it, and it's much more extensive than I originally expected (like an entire extra tech tree!). I'm surprised by how well-balanced the mod already is, and altough the mod is still quite rough around the edges (which is expectable), I think the overall experience is great. I just want to get that said before diving down into all the observations and suggestions below.

So, I'm one of those players that is currently cheesing the mod, mostly by completely ignoring the defense of the warp platform.

I also use remote mining locations outside of the pollution cloud, but to me, that seems a valid intended use case of the warp harvester mining platforms... because who needs to "warp" resources when you're mining them literally next to the platform!

In terms of "cowardly cheese", and also in my own defense I guess lol, simply ignoring the warp platform defense altogether is really NOT all that functionally different from the player warping away prematurely warpzone after warpzone... However it sure does FEEL a lot more cheesy, and should perhaps be demotivated.

The simplest option I could think of is just spawning the physical, damaged warp reactor from the get-go and allowing biters to damage and destroy it in a giant, game-ending explosion. (This could be a great addition to the "options" menu to keep both playstyles possible. Also, this requires spawning without the crashed spaceship, but thematically the crashed spaceship doesn't really align with the warp reactor story anyway, so no loss imo)

A different, but possibly harder to implement solution, is to allow biters access to using the teleporter between the warp platform and the factory floor (and further down).

(tangent: they could alternatively be granted access to ALL teleporters, but in that case the 4 turrets should spawn as "closed" teleporters, unusable for both player and biters, until the player manually (and definitively) "opens" them through a GUI interaction or smt.)

Other Suggestions:

* Option to NOT reset biter evolution to 0 when warping "home" to reclaim your starter planet. It feels very anticlimactic, you're getting ready for the big moment, finally having gathered the strength to try to reclaim your home planet after progressing through countless warpzone, it should be the Final Showdown, a fight to remember!
  (and, because the surface remains loaded all game long, the enemy expansion has continued during the player's long absence as well, spawning big biters on the homeworld already if the evolution during expansion happened to be high enough (this is all good and fits well thematically)).
  Evolution seems a global value (well, 'a LITERALLY universal value' may be a better fit in this case lol), so it's probably hard to keep track off independently. To prevent a quick "evolution-reset-warp" before returning home, I suggest setting it at 0.90 or close to it, right at the very start of the behemoth biter era, and/or making the value configurable in the options.
* For lag reasons (too much biter pathing after several hours on a planet), it would be great if, once you finally manage to warp back home, there was a way to disble the warp platform generating immense pollution.

Perhaps we could "repair" the reactor once we're back on our home planet, and/or only when the (repaired) warp reactor is running on warponium fuel, warp platform pollution emission is paused. (the main problem of unstoppable pollution is the ever increasing fps drop caused by biter pathing after a few hours, which means the homeworld map becomes unplayable unless you start off on an island/continent style map and wipe all biters from it. The pollution from the factory itself should still spread and attract biters, to still generate attacks from that pollution, it's possible to drastically lower the pollution spreading threshold (usually 15), and a low multiplier for pollution-per-attack-biter could be used as well.

In the options, adding a column of "earliest possible warpzone this planet type appears" next to the "relative chance this planet is selected as the next warpzone" would be helpful and insightful I think.

==========

I propose a shuffle of these 3 planet types/descriptions. This might be just my personal confusion, but:

* the current "Uncharted planet" uses your "Homeworld" settings, and thus should "feel like home" and be a "normal planet".
* the current "Normal planet" (which uses factorio's default map settings as far as I can tell) potentially doesn't feel like home at all, depending on the map settings you chose to start off with. It actually feels more like "an average planet", as it's basically the same "average/default factorio experience" every time, unlike the "something is missing" planet type. It could even have the text of the current avg planet minus the "but...missing" part.
* The current "Average planet" is actually the one that plays the most unpredictable depending on the missing resource type, and would be greatly suited to be the "uncharted" one.

===========

My opinion on some other recent topics:

* The endgame SPM-possibility is fine as it is, and does not need reworking (4-digit SPM is easily possible purely inside, and after settling or return to homeworld you can also build a "real" factory outside to complement the one inside)
* I agree most tech descriptions could use better naming/descriptions (like the harvester platforms are missing the level 0 "unlocking" technology, and instead are unlocked by a "increase size" technology (harvester E/W platform size 1)
* I agree hazard concrete is the way to go to indicate future locations of spawned-in elements, like the warp pipe on the mining platform
* It'd be great if descriptions like "warning: this technology recalls your harvesters upon completion" could be added to those that do.
* it feels wrong that Reactor abilities (like Charting ability) uses power as a percentage of the capacity of the "warp accumulator", instead of having the same power usage curve regardless of "energy flow rate" technology level. This punishes you for researching higher energy flow rate, and thematically feels very strange that your scanning power goes DOWN dramatically with every new research.
* the default logistics chest upgrade should be a type that doesn't unexpectedly mess up your base. IMO the best option is the green buffer chest, but passive provider is ok too. You can then change it to something else in the settings AFTER unlocking them for the first time, instead of reloading out of sheer agony
* About the warp armor and warp strider being uncraftable in assembly machines: I don't have a fix, but I noticed that Spidertrons DO stack in the assembler (whereas the armor types do not), and spidertrons are unstackable items with inventory grids, similar to armor. Not sure if this helps, but eh
* Change win condition (and goal/storyline) to the warping home event
* I don't see a huge problem with the strategy of "staying behind on your home planet, wait for pollution to dissipate, then play a vanilla game of factorio. If you choose to play like this, then why even install the mod! That being said, I have nothing against disabling the option to play like this somehow. An easy method to implement could be, only resetting the evolution factor if the PLAYER warps to a new warpzone. Good luck beating big biters within the hour, and behemoth biters an hour or so later.

Anyway, the only real usecase where it would be useful to prevent the player from staying behind is for speedrunning, or for self-proclaimed youtoober challenges like "Beating warptorio in 8 warpzones" like this guy --> <https://youtu.be/gqDYr4hgcCM>

---
**Puppy:** The stabiliser can prevent the warp reactor generating a significant amount of pollution; I won my previous playthrough after staying in the same warpzone for six hours and rebuilding my entire base as a plain main bus outside the reactor. Presumably there's some limit but it feels like an unoptimised base will make more pollution; I could easily scout ahead of my pollution cloud even after many hours. Obviously there is the issue of the weird energy costs..

I am curious to see in your series if you cheese things by not researching the platform stairs energy upgrades then running the stabiliser a lot.
