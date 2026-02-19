# entitiy:coal:probability can't be infinite

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/684193b7adcd0af17a468c93
- Thread ID: 684193b7adcd0af17a468c93
- Started by: FiftyShadesOfGames

---
**FiftyShadesOfGames (op):** Received Error message entitiy:coal:probability noise expression: VaribalePersistenceMultioctaveNoise:offset\_x can't be infinite. I was on 0.9.27 when the crash occured the first time.

Ofc I've updated mod afterwards to see if this fixes the issue.

Now on 0.9.45 I can't load savegame anymore due to that exception.

---
**FiftyShadesOfGames (op):** In case it helps, you can check the save file out:
<http://fiftyshadesofgames.de/factorio/saves/warpdrivemaschine_28.zip>

---
**MFerrari (mod author):** Unfortunatelly you will have to keep the base game on version 2.0.47 at max.... after that, the deve added a bunch of octaves map checking that does not leave your save to load. When you finish the run, then you may update the game
