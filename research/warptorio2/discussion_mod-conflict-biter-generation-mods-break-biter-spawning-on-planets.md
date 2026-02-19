# [Mod Conflict] Biter generation mods break biter spawning on planets

- URL: https://mods.factorio.com/mod/warptorio2/discussion/603232607b8fb9ef29a0b30a
- Thread ID: 603232607b8fb9ef29a0b30a
- Started by: LemonZawodowiec

---
**LemonZawodowiec (op):** Hi
In earlier versions of the game i played Warptorio with combination of Bob's & Arch666Angel mods...
Long and grueling play but i liked it...

---

Now i wanted to play this in latest version but stuff and things happened... basically world moved forward...

Arch666Angel in his generosity and awesomeness decided to add a slider to map generator "Angel's Enemy Multiplier"...
Which basically means if you want to play angels mods with biters enabled this slider must be set to MAX (all the way to the right)

---

Now my assumptions come into play... I assume that Warptorio when sends player to another planet gives random values to map generator sliders
of course in a set parameters (so semi-random). This means that "Angel's Enemy Multiplier" slider gets other value than MAX...
This makes it so i have no biters on any other world other than first one...
I reached out to Arch666Angel "Development and Discussion" forum to ask how to delete this slider completely... so far no answer...

---

So i thought if this can be somehow solved on this side in a simple manner?
Would it be possible to check if Arch666Angel mods are present and if they are then leave out the "Angel's Enemy Multiplier" from randomization?
I don't know... maybe it just that i'm dumb as a log and cant set up these mods correctly?

---

If someone want to check if i speak real stuff you can check yourself by downloading a pack like this
Bobs+Angel mods
Warptorio mod
set the "Angel's Enemy Multiplier" slider to the max
start the new game
use the command to reveal huge portion of map on world one to check biters present
warp to the next random world
use command again to see biters are gone
you can check this by creating several new games again and again and save before warping next world (next world is not always the same after reload)

---
**PyroFire (mod author):** Trying to diagnose problems yourself when you have no programming experience is often worse than unhelpful, it can misdirect people about the wrong things and I am left as a detective to figure out what is and is not part of the problem.

What you have described sounds like a mod conflict with one of the Angel's mods causing biters to not spawn on surfaces other than nauvis.

It is more likely that angel's mod has custom biter nest generation, but this just an educated guess.
It could be any number of different things.
The Rampant mod has a similar conflict.

There are a lot of bobs and angel's mods, could you post a link to which specific mod creates the conflict?
If you are unsure, it can help to remove 1~2 mods at a time until you have found the conflict.

---
**ukilop:** Any news on this? Because it seems like more than angels is affected here, seems like anything that changes spawning rules just don’t work past the first planet, Bob’s ore, angels ore, alien loot economy, Bob’s aliens (I think),

---
**PyroFire (mod author):** > Any news on this? Because it seems like more than angels is affected here

As explained, this issue is seen in other mods like Rampant.
This is why Rampant is marked as conflict.
I cannot fix other mods changing biter code to only work on nauvis (like Rampant does): This is the most likely cause.

As previously explained, please provide specific mods causing the conflict if you want to know more: There are a lot of bobs and angels mods.
