# Multiplayer event finished, ideas and suggestions

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5ed2c6073d9811000b9ef822
- Thread ID: 5ed2c6073d9811000b9ef822
- Started by: TSP

---
**TSP (op):** Hello,

So we had that multiplayer event and I wanted to share my thoughts on the mod as it stands right now. Hopefully you will find some points useful.

The event started off a week ago on a Saturday afternoon. We had people come and go all the time, we averaged out with about 5 people online at any given time for the weekend. It dropped after that to 1-3 at any given time until the last few days in which I've mostly been playing it alone. I completely finished the whole thing, with bot-based everything and a personally designed (only took me 6 hours, *cough*) 1120 MW no-waste reactor to fit in the boiler room, because all the BP's in the world didn't have one that'd fit in the Warptorio 2 boiler room.

Forest worlds are greatly balanced. You did a splendid job here changing it from "once we go there we never wanna leave" to "It's still a great place to be, but can't push it too far".

Then there's a problem with defense progression. After some point with damage researches you can hold on for about 105-115 minutes. This is when biters will reach the 0.9 evolution and behemoths start coming in. This is pre-laser turrets. Just turrets with piercing ammo and some upgrades. Once the breakpoint happens, everything collapses. This is especially punishing when alone, as you can't pack up everything at once.

Now here's the issue: It never changes. I got laser turrets and laser turret damage upgrade 11 (Which is 4 tiers in space science I think?) and yet, once the 0.9 breakpoint happens, it's already too late. Everything starts folding. Even with substations and 3 entire rows of laser turrets (!). The issue is, the boiler room can only sustain a 1120 MW reactor (at best, I doubt anyone has personally designed such a reactor for warptorio2) and the area you have to protect to beat a 0.9 factor enemy would be gigantic.

So the only resolution here is to just pack up around the 100 minute marker, and just never bother with laser turret damage upgrades past 5 or so. It's just not effective. it doesn't feel satisfying. "Yeah, I can hold out until 0.95 now" just never happens. Warptorio2's biter attack system was developed way before Wube started removing the biter collision system; if that system was still there, I'm 100% sure we could have gone past 0.9 way sooner. But just the fact that you will get 20-30 biter bases on just one side (ie. west) attacking with behemoths is just a 8x health increase, and the pollution exponent makes it worse very fast. so even if you can handle 0.9 for a few waves (it's just not worth it btw, power-wise) it'll just take a few minutes to reach the next breakpoint and reach 50 other bases on all sides.

Biter balance aside... Throughout the entire Warptorio2 playthrough right until end-game bots, smelting was always an issue. The harvester room never ever provides enough smelting space (Or even a quarter) to keep half a factory floor running. A lot of smelting is done on the factory floor due to sheer space issues until end-game bots. And even then we tended to just do on-site smelting for 30-50 minutes. This was a real shame because this never resolved itself with researches. The harvester room was always awkward to use due to its oval design, not to mention that the harvester platform researches caused glitches because it spawned its extra space onto existing storage chests in the harvester floor, so it'd break those storage chests/inserters/roboports that were part of the harvester floor suddenly are part of the harvester platform and some of it would overlap with both harvester platform loaders and harvester floor loaders.

As for the factory floor, You never wanted to build outside of the warp beacon's influence area. Especially end-game with the warp modules. This means that the "giga space" researches were pointless. You'd rather super-condense all production into the warp beacon's influence zone because of the massive speed and productivity boost. And this meant that you were absolutely required to go entirely bot based. Even fluids were bot-based.

So end-game, you don't want to use any belts, you don't want to use the giga spaces.

Also, there's an infinite resources loop... 50 fluid goes in a barrel, 50 comes out. Apply a 10 slot Warp Module-d warp beacon and 4-warp module-d assembly. and you have 50 fluid going in and 120 fluid going out... Even just 1 warp module would break the equivalent exchange rule.

Boiler room Floor. My 1120 MW reactor needed all the pumps in the water area. You can only place 16 pumps with the pump rework they did until the end-game water tech. But by that time you're already finished so the 1120 MW reactor is the best you can do.

This was the result btw: <https://i.imgur.com/hdKyt0i.png> and BP if anyone wants to use it: <https://pastebin.com/dhnAkELe>
You need to add in the first fuel cell in each reactor and the inserters need to be able to grab a new one at all times for this to work. Never had an issue with it over 2 days of play after initial setup.

Was quite proud of it to be honest.

Anyway, the mod is a blast, but there are definitely issues. And our disappointment was great when the powers barely did anything aside from sucking up all the power. And Warp loaders... Ah I remember how good they were until you broke them.

---
**PyroFire (mod author):** Great feedback! there is quite a lot to unpack here.

The barrelling recipes need to be removed from the warp-productivity bonuses, that's relatively easy.
Everything else is more involved.

Water - looks like increasing the max size by 1 will give an extra pump, enabling up to 24 pumps instead of 16.
Given this water ratio issue it may be worth putting some water in the giga areas too.

Factory floor giga beacons - This has been suggested a couple of times, and there's a couple of reasons to say no.
For now i'm not going to make any changes here and will explore other options instead.

Harvester floor circle area is awkward - Yes it is! and i'm very curious to see how peoples factories have turned out with it. However I don't see much need for it to be changed at this time.

Biter balance / defence progression - Not only is the evolution factor directly tied to pollution which increases exponentially, but warptorio also increases the biter base expansion rate - I don't often see this discussed or noticed, but both of these things I can agree gets absolutely out of hand after being on a planet for a long time.
Adding a thing that causes the pollution growth factor to slow down after a point would resolve most of those difficulty spikes. The reason being that a growth difference between 0.0 to 0.1 is actually considerably less "potent" than from 0.8 to 0.9. But right now, because the growth factor doesn't slow down, it jumps from 0.5 to 0.9 in the same time it took to get from 0.4 to 0.5.

Platform abilities are underpowered due to extreme energy usage - I'm glad they're working properly and effectively! I'm looking for suggestions on ways to better balance this power usage, but the actual function of it won't change (drain an increasing amount of power to get & sustain some bonus(es)).

Another factor to consider is that there are plans to add new platform layouts, so each floor has different shapes and functions (e.g. the factory floor could be replaced with some hybrid of factory/boiler, and the boiler floor is changed to a teleporter hub, then add lots of stairs between those floors) or something.
This should add some extra replayability to the mod.

---
**TSP (op):** Since you were interested in the harvester floor method, this is the one we used in the end-game: <https://i.imgur.com/H93zyfc.jpg>
It wasn't finished (you can see modules missing) but we finished the event anyway so I didn't bother optimizing it with warp modules or move it to the factory floor for the giga floors or whatever.

The problem for me is, and this is entirely personal, is that I really love using belts over bots as much as possible. But that's simply not viable in end-game because of the space limitations, so I just had to deal with it.

Thanks for the response though. I am definitely looking forward to seeing more features and/or difficulty/space challenges and solutions; like that instant train unloader (even though we didn't use that part in this event because we needed to move every 100 minutes anyway). New platforms and mechanics are always welcome, and I've always loved your harvester platforms once you introduced those. (The floor, not so much :P, but it was good that it was there rather than the floor not existing at all a long while back )
