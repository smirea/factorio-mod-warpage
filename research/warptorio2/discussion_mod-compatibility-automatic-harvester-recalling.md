# [Mod Compatibility] Automatic Harvester Recalling

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6675dc88ad7fcc95f5f30000
- Thread ID: 6675dc88ad7fcc95f5f30000
- Started by: KiNg626

---
**KiNg626 (op):** By adding the player creation flag and defining a placeable\_by, the harvesters can be deconstructed, allowing for automatic retrieval of the harvesters (with something like Recursive Blueprints). I've included the changed lines below, which are lines 32-36 in data\_warptorio-harvester.lua

local t=ExtendDataCopy("accumulator","warptorio-teleporter-0",{name="warptorio-harvestportal-0",
minable={mining\_time=5,result="warptorio-harvestportal-1"},flags = {"player-creation"},placeable\_by = {item = "warptorio-harvestportal-1", count=1},energy\_source={buffer\_capacity="5MJ",input\_flow\_limit="500kW",output\_flow\_limit="500kW"}},false)

local t=ExtendDataCopy("accumulator","warptorio-teleporter-0",{name="warptorio-harvestportal-1",
minable={mining\_time=5,result="warptorio-harvestportal-1"},flags={"player-creation"},placeable\_by={item="warptorio-harvestportal-1", count=1},energy\_source={buffer\_capacity="10MJ",input\_flow\_limit="500MW",output\_flow\_limit="500MW"}},true)

---
**PyroFire (mod author):** By editing anything, anything is possible. Is this specifically a request for compatibility with recursive blueprints? are there any other mod compatibilities this is intended for?
