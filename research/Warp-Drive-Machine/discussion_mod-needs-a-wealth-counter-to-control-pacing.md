# Mod needs a "wealth" counter to control pacing

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68ac658f8eaf082b77808370
- Thread ID: 68ac658f8eaf082b77808370
- Started by: NeoChaos12

---
**NeoChaos12 (op):** I think the current gameplay loop really requires some sort of internal "progress" or "wealth" counter to modulate (scale the difficulty up and down) the random aspects of the game for a smoother experience. Let me explain what I mean by first highlighting some pain points -

1. Unlocking techs dilutes all the cost and drop tables in a way that is not necessarily proportionate to the difficulty of crafting the newly unlocked item at that stage of the game. E.g. costs changing from demanding the equivalent of 100 iron plates to now demanding 100 steel immediately after unlocking steel.
2. Warponium ore, especially early to mid-game, is disproportionately and wildly more difficult to acquire than the other basic ores, but the game doesn't seem to acknowledge that.
3. Recovering from a setback (e.g. loss of surface platform) can become impossible because the repair costs reflect progress on the tech tree, but those tech tree unlocks themselves only benefit the player when one is able to use them in conjunction - thus, the loss of critical surface-infrastructure (the platform terminal) can soft-lock runs. e.g. it's impossible to gain the speed-up benefits of electric miners (when no warp power tower is available) over burner miners if the platform power is broken. So, one gets thrown back into using burner-level tech but must now gather resources equivalent to, say, nuclear-level tech in order to repair the platform.

A counter like this should be relatively easy for Factorio - for every entity and stored resource on the platform, calculate the raw ore costs by back-tracking through the item recipes and adding a fixed cost for each second of processing. Then, the only remaining calibration is the relative costs of raw ores, since uranium and warponium should definitely be rated as higher cost than iron ore and stone. Using the weighted sum of raw ore costs gives a wealth heuristic. This counter can be used to smoothen out just about every random aspect of the gampelay -

1. Difficulty settings (starting area size, enemy types and difficulty, etc.) of planets
2. Ore distribution
3. Market item availability and prices

and more. Consult Rimworld for details, I suppose.
