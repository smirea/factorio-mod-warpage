# Warping causes massive lag in multiplayer [in progress]

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/6800d6e7ebbd8fcd648cbb5c
- Thread ID: 6800d6e7ebbd8fcd648cbb5c
- Started by: lachtanek

---
**lachtanek (op):** Hi, when playing multiplayer through steam play with my friend, whenever we warp, I (as a client) get a massive lag (the "buffer" number jumps high and latency increases), while he (the host) works without any noticeable issue. I think the later in the game we are, the worse the lag is, but I don't have any hard stats on this, though it would make sense (more entitites etc). Last we tried was yesterday and we might have been on 0.0.15 still, but according to the changelog no changes related to this were done.
I am not sure if it's just me, as we do not have others to play with us, but it does happen to me on 2 different computers (mac, linux).
Is there anything we can do to help debug this? Or is this maybe not easily redeemed just due to the sheer number of data that must be transferred (new surface with all the shit)?
Thanks for any responses and thanks for a fun mod!

---
**Venca123 (mod author):** It would be possible to make the lag during the warp not so horrible (and it is planned to be improved in future) but right now there is not much you can do. The issue is that new planet is generated during a single game tick (generate new planet, duplicate platform, transfer users to new platform, remove one of the old warpzones (last one is always available and every other is deleted) and finally delete old platform)

Sadly there is probably not much you can do about it as a player right now

---
**lachtanek (op):** Out of curiosity what's your plan for addressing this? Off the top of my head I can think of making it happen over multiple ticks (seems simplest, but probably needs to somehow convey this to the player, with some loading bar or cinematic or something).
Also maybe maybe pre-generating all planets could be interesting optimization, at least the terrain would be ready after you jump.
Or maybe always keeping the existing surface you are on but just generating the terrain around you according to rules, but I imagine this would be harder to do 'cause might need to duplicate generating logic for all planets.
Thanks!

---
**Venca123 (mod author):** Doing it over multiple ticks will be fine since it should take around 8 ticks in total to spread it. I just need to make few more changes to make it work

---
**Venca123 (mod author):** This should be now improved

---
**lachtanek (op):** thanks! will let you know once we return to the game, we haven't had time to play for a month now
