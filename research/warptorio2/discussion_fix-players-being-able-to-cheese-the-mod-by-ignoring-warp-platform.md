# Fix players being able to cheese the mod by ignoring warp platform

- URL: https://mods.factorio.com/mod/warptorio2/discussion/657eff22395b20559d4c51b9
- Thread ID: 657eff22395b20559d4c51b9
- Started by: Aqo

---
**Aqo (op):** The challenges presented by this mod (limited build area, and constantly high pollution) can be completely mitigated by players just... walking away.
I think the mod is fun and ideally I'd prefer if it nudged me and any other player towards "playing it as intended" and not just cheesing it.
So, some mechanic has to be in place to prevent players from gaining an obvious big advantage by just "walking away" from the warp platform.

We discussed this over discord. A solution by Pyrofire himself, which I think is cool and I support, is this:
- if a player is located on nauvis and the warp platform isn't there, and the "Warptorio Homeworld" research isn't researched, the player dies.
- if a player is located on not-nauvis and the warp platform isn't there, there will still be a constant flood of pollution, just as if the warp platform is there.

Hopefully those two changes will encourage players to actually stick with the warp platform all the way to the end, instead of cheesing it by just abandoning it.

---
**PyroFire (mod author):** Thinking about it more carefully, why must the player just simply die on nauvis? Why not just order every biter on the planet to attack them like biter waves but more overpowered? If anyone can manage to launch a rocket under this situation, all the power to them hey? Probably not possible but very unlikely to beat it lol.

For non-nauvis and non-homeworld planet anti-cheese, this will have a small performance penalty in a few places. Do you think the performance penalty is worth it?

---
**Aqo (op):** > Why not just order every biter on the planet to attack them like biter waves but more overpowered?

I like that more than just randomly dying, sounds perfect :)

> Do you think the performance penalty is worth it?

How bad is it? If it makes the game unplayable, then I don't think it's worth it, but if it's just a small negligible thing, yes I think it's definitely worth it.
The thing is, I think in an ideal design, if somebody is trying to play a mod "in the best way possible", it should force them to utilize the mod's features to their fullest, and not do the opposite, where "the winning move is not to play".
Factorio is a game about optimizing your designs and your strategy and getting faster each time.

Right now it seems like the ideal way to play warptorio is just walking away from the warp factory, which is really disappointing. I want to learn ways to improve playing around the warp factory challenge, but minmaxing it just tells me that the best way to upgrade the warp factory the fastest is to just leave it alone. If I enter a sandbox mindset and go "ok, lets stay on the warp factory, even though this is objectively the worst move", it just makes the whole experience feel kinda "meh", like I'm forcing myself to be ignorant.

I just tested this. Image included: <https://i.imgur.com/3HX3cWO.png>
Although the pollution cloud caused by the warp platform is big, it is far from infinite, and it doesn't keep growing forever. I left my game running for an hour, after 30 minutes there was no change in the pollution cloud size, it reached an equilibrium. It's very easy for a player to just make a car, drive away for like 5 minutes in one direction, find some ore patches which have ridiculous scale due to the distance from spawn, and then just make your whole factory there.

Once you research Warp Reactor 6, the auto-warp timer is gone, so even if we add the aforementioned mechanics that would penalize the player for leaving the warp factory behind, it is still in the player's best interest to just rush to this technology and then just essentially play vanilla at a far spot from spawn.

This, combined with the fact that every time you warp the biter evolution is reset to 0%, and that there are a lot of warp bullet upgrades that make turrets very OP, means that the player can just warp -> drive far away -> put down turrets to clear nests instantly which is very easy as you're only dealing with completely unevolved biters -> create a perimeter large enough for a full scale factory next to large ore patches -> just play vanilla and beat the whole game there.

I think it's bad design if the winning move is to not play the game. The player should be incentivized to to actually play around the warp platform.

Here are some ideas to counter this cheese:
- Make it so that there's always an auto-warp timer. Just make the warp reactor researches always make it gradually bigger, but never fully go away.
- Make ore patch size and richness go down instead of up as you move further from spawn, so that you're encouraged to mine next to your warp platform and not away from it.
- I support the idea of making all biters gang up on the player if the warp factory ever leaves, it's pretty cool and it feels natural with the flow of the game

If those changes are implemented, it would mean:

1. ditching the warp platform behind either right away or after a few warps is never a good idea, because you get ganged up by biters and die, so players would feel encouraged to stick together with the warp factory.
2. the next closest thing to ditching the warp platform would be letting it stay on the same surface as you, but just play the whole game away from it. this is only made possible due to Warp Reactor Re-Assembly Project 6 research completely disabling the auto-warp timer. If this research instead does not disable the timer, and simply extends it like the ones before it in this chain, then building your whole base away from the warp platform is not viable as eventually the warp platform will go away and then you get ganged up by biters and die
3. the next closest thing to ditching the warp platform (with the above two in place) would be to still drive far away and build there, with robots, using blueprints, and just pack everything up and go back into your warp platform at the last moment. I think it's fine if this general gameplay style is still possible, but having small ineffective ore patches at a distance would mean the player still has to mine within the pollution cloud, thus still having to deal with the warp platform considerations, instead of completely ignoring it, building nothing on top of the warp floor at all, and just mining elsewhere far away

---
**Tuscatsi:** Consider the following:

* remove the option to eliminate biters on the platform during warp;
* any biters on the platform (but not the corner installations) during a warp are randomly distributed through the interior surfaces (factory, harvest, boiler);
* after 15 seconds of chewing on your stuff, they explode like grenades due to "warp instability";
* if the player is not on an inside surface, the platform, or a harvest platform during warp, all equipped and unequipped inventory is removed and lost forever, the player is reduced to 1 hitpoint, and relocated to the platform just above the planetary warp gate.

This way, you're always forced to warp with the platform, and strongly encouraged to protect the platform from the tower defense element.

I like the idea of not disabling the auto-warp timer. This could be replaced with infinite research that extends the timer 10 minutes per level, available only after white science.

Some of the drawbacks to these suggestions include:

* no use for "establishing a homeworld" if you can't settle permanently somewhere;
* I can't see a good use case for the rail car transporter areas if you're not stable/permanent enough to set up rail networks.

---
**ichbestimmtnicht:** maybe use Rampant as dependency for additional biter logic. There is an option for player pheromones attracting biters to the player and spots of interest.

---
**Aqo (op):** even then the run basically just becomes playing vanilla rampant

there needs to be something built-in that makes staying on the warp platform more beneficial than avoiding it

---
**Beefy_Swain:** Someone on the discord suggested making it only possible to place labs on the platform. I think that is a very elegant solution.

---
**PoppuTheWeak:** My 2 cents: that'd be really evil, because you wouldn't benefit from the warp beacon's influence (bye bye 100% productivity bonus!), and you couldn't really automate science pack without putting too many things on the main platform. So probably manual science pack moving from factory floor to platform floor. Automating it would probably require logic circuits to control what is transferred between factory & platform.

Alternative without any deep thinking: if some building/reactor on the platform is destroyed, you warp immediately, and an explosion occurs on the factory platform itself, around the stairs, maybe on levels below too - warp instability is bad!

---
**Aqo (op):** I like Tuscatsi's ideas
