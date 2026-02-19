# Biter pathfinding is 'broken' if you don't build on the warp platform

- URL: https://mods.factorio.com/mod/warptorio2/discussion/658634cd936b4e5dd17078da
- Thread ID: 658634cd936b4e5dd17078da
- Started by: CapainOblivious

---
**CapainOblivious (op):** Through a few hours of experimentation, I've figured out that the difficulty of this mod drops off a cliff if you build just 2-3 chunks away from the Warp Platform and avoid building on the WP (surface) itself.

How I understand the problem is in three parts:
1) Biter attacks try to target the largest source of pollution (the Warp Platform)
2) The attack pathfinder only looks so far for buildings around the targeted area (buildings not on or immediately next to the WP are missed)
3) If the attack pathfinder can't find buildings, a 5x5 square of chunks around the attack's origin are marked as 'bad attack chunks' (check the debug menu for it) for 10-20 minutes, which prevents any other attack from originating in those chunks while still marked.

Near as I can tell, this means that if you build a few chunks away from the WP (like on a starter ore patch), upwards of 90% of all biter bases will fail to spot your buildings when they first attempt an attack because they're targeting the WP. The few that do spot your buildings only did so out of dumb luck because your building were in the pathfinder's way. The further away from the WP or the more inconvenient of a spot you're in, the less likely that any attacks spot you. If there were a large lake and you built on shore nearer to the WP, I wouldn't doubt that's it's possible to not get attacked at all, even while still firmly inside the pollution cloud.

Note that this isn't biters themselves failing to spot your base, but the attack pathfinder that send the biters in the first place; for failed attacks, biters never even show up to the rally point.

I don't know what can be done to fix this. At the very least, if you could find some way to disable the 'bad attack chunks' system or reduce their time-out significantly, it'd reduce some of the issues, although at the cost of performance.

I'm going to try adding Rampant to see if its AI has more luck at finding buildings away from the WP; if it goes well, I might suggest that you add it as an optional dependency.

---
**PyroFire (mod author):** Your first assumption is incorrect. Biters are only attracted to things that emit pollution (and can be attacked). That's why they usually don't attack power poles you placed far away from your factory. Biter attacks are scripted to attack the platform's location even if it is empty, which is not normal. There's no way to really "fix" this, except for putting a building that emits pollution on the platform and giving you a game-over type thing if it gets destroyed, such as the warp reactor.
Another option would be to add additional biter wave targets towards the player and the harvesters, but I think that is a bit too much.
Otherwise, I would consider this to be valid cheese and "working as intended".

... Or I just let biters enter the stairs :)

---
**Tuscatsi:** Why is there no warp reactor on the platform from the beginning? I know that one of the techs mid-tree fixes it and that it suddenly appears. Why not have a broken reactor on the platform from the start? (You might need to increase the platform size slightly to compensate for 25 fewer usable tiles). Let it be the source of the pollution, destructible by the biters, and gives a game over condition if destroyed? It later upgrades to the functional reactor with all the same conditions applied (pollution emitter, damageable, game over).

In my current game, I let a built-up platform warp away without me from an ocean world. I was transported to Nauvis, the platform ended up on a Normal world, and the biters then (eventually) ate everything on the platform, except the warp reactor which was unlocked at this point. The above change would solve the biter pathing issue OP stated (because there would be a game-ending pollution-emitting stationary and non-removeable target on the platform at all times) and force the player to actively defend the platform. Yes, technically you could build some impregnable defenses on it and let it warp away, but by that point you've already invested a ton of time, tech and resources building it up, and it seems unlikely a player would want to abandon that, plus you're still fulfilling the objective of defending the reactor even though you lose access to the factory.

---
**Tuscatsi:** I tried a second time, and was not transported to Nauvis. Seems I was only moved the first time due to being in a vehicle at the time of warp. Otherwise, I was stranded on the ocean world, which isn't a particularly useful place to be. Perhaps that behavior could be considered a bug.

---
**PyroFire (mod author):** A lose-condition broken reactor that exists from the start of the game to act as a "hard-mode" is currently being considered.
This not existing at the moment is currently considered an intended feature and not a bug.

Mod-settings are poorly cooperative with such ideas as difficulty preset settings, such is the case for the carebear chest which is unfortunately an unsolved problem for Wube at the moment.

But as far as a game-over condition like this goes, it is very much under consideration as a difficulty setting similar-but-opposite to the carebear chest.
