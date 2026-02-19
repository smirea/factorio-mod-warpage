# Surface Selection Issues in Map View

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/67d82955e379e18342be4387
- Thread ID: 67d82955e379e18342be4387
- Started by: DracoFalconi

---
**DracoFalconi (op):** Started a new play-through and ran into this issue while on Warpzone 4.

Went in to map view while on my Ground Platform and saw my Surfaces list, containing Nauvis, factory, warpzone\_3, and warpzone\_4.
Clicked Nauvis, it showed me Nauvis (no detail because no radar or presence).
Clicked warpzone\_3, it showed me Warpzone 3 (no detail because no radar or presence).
Clicked factory, *map view closed immediately and returned me to normal gameplay.* That's not right...

Tested it while on the Factory Floor. Nauvis and warpzone\_3 behaved as expected, warpzone\_4 closed map view immediately.

I cannot imagine this is expected behavior...

---
**Venca123 (mod author):** This is known issue and I am already fixing it. Basically my check for teleporting does not work as expected and you can teleport between platforms in map view mode as well as normally walking

---
**DracoFalconi (op):** .... Oh, I hadn't even realized I had actually *teleported* to that surface. My bad, I do see there's an open thread for that. I presumed I was just leaving Map View unintentionally.

---
**DracoFalconi (op):** Wait. I just double-backed on this and tested again. I was *not* being warped to the platform I was selecting. it *only* removed me from map view. if I clicked the factory surface from the current warp zone, I still remained in that current warp zone, and not in the factory floor.
