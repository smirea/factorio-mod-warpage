# Stabiliser costs are really weird

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65971031423aabe1d5695166
- Thread ID: 65971031423aabe1d5695166
- Started by: Puppy

---
**Puppy (op):** I've reached the end of the normal tech tree in Warptorio, now looking to go to space. The main issue is simply that the factory floor doesn't seem to support a great SPM and research takes a long time. I've been looking at building more things outside the inner floors of the warp platform, but to make this worth it considering the time to pick up and leave, obviously I want to extend my stay on any given world as long as possible. For this I'm using the stabiliser. However the energy costs of the stabiliser are .. really weird.

The biggest issue is the way that the stabiliser costs relate to the warp platform's own energy. Since we pay a percentage of the platform's energy, then researching the platform stairs upgrades makes the stabiliser way more expensive. The player has many copies of the platform stairs so every upgrade adds many times the upgrade's increase in total buffer and therefore increases the maintenance cost hugely. This is very counterintuitive and quite punishing. You also save some energy by not using the harvester platforms which also feels bad. Additionally since the warp accumulator counts as warp platform buffer, this seems like a terrible decision to make one, as it would immediately shoot up your stabilisation costs.

The second issue is the way the stabiliser costs relate to the maximum input/output of the platform stairs. The maximum rate is 25% of the buffer per tick, or 15x the buffer size in watts. However most levels of the platform stairs don't have enough input/output to actually supply this as they add more buffer than they can sustain, even spreading the load across all the surface (most numerous) stairs. The platform teleporter on the other hand has a ton of input/output and a tiny buffer. So the player can spam upgrades here and then run the stabiliser indefinitely with this input/output as long as they didn't research too many stairs upgrades. And it's super easy to do this if you didn't research the stairs energy upgrades.

It feels like the cost scaling should be more fixed, as the current system is really punishing for players who don't understand it and super exploitable for players who do know how it works, as they can get very cheap stabilisation by simply never researching the platform stairs upgrades.

---
**PyroFire (mod author):** Open to suggestions as to what this "fix" would look like.

---
**Puppy (op):** I would have suggested a fairly simple time-based increase like 1GW per hour, squared. Also, kindly ignore my criticism about the factory floor being too slow; I hadn't realised how incredibly badass the Warp Beacon is.

---
**PyroFire (mod author):** Time-based increases will eventually out-pace growth and become impossible. Any other ideas?
Also, the warp beacon is overpowered. Working as intended.

---
**Puppy (op):** The growth can always see some cap like 10 or 20 GW, but depending on the design intent, having it become impossible seems more like a pro than a con; if the player can always match the growth rate then the Warp part of the game is basically over and they can win the game vanilla-style. It feels like the player shouldn't be allowed to set up shop permanently outside the platform except on their homeworld.

Perhaps a more elegant solution would be to forget power costs entirely and simply have the stabiliser only run for a fixed time per warp zone, like 30 or 60 minutes. This makes the upgrade strong but doesn't let the player break things, and easy to use.
