# Alien biomes trees missing

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6467cc99c6dcf08d6cfc0f87
- Thread ID: 6467cc99c6dcf08d6cfc0f87
- Started by: elanu

---
**elanu (op):** When using alien biomes the regular planets intended to be nauvis-like only have dead trees.
Something is not working with the autoplace settings. Uncharted world works fine, but most others don't.

I made a hacky 'fix' in the form of a console command, though it doesn't produce the intended behaviour and just copies settings
from the uncharted world to the other planet types. If anyone wishes to use it in their current runs in lieu of waiting for a proper fix,
I'll post the code below.

Trees are restored on subsequent warps, though it means abandoning any attempt at making planets look like vanilla nauvis.

---
**elanu (op):** just put this in control.lua in a personal mod or something and run it with /fixtrees

commands.add\_command("fixtrees", "fix tree spawning on default planets", function(event)
--these planets have modifiers[1][1]="nauvis", which prevents alien biomes trees from spawning
--replace "nauvis" with "copy\_nauvis", which is used by the uncharted planet and works fine
--the following special planets are left with "nauvis": barren, biter, jungle, midnight, ocean, rogue

```
    local planetlist={"average", "coal", "copper", "dwarf", "iron", "normal", "oil", "polluted", "rich", "stone", "uranium"}
    for k,v in pairs(planetlist) do
            tmp=remote.call("planets","GetTemplate",v)
            tmp.modifiers[1][1]="copy_nauvis"
            remote.call("planets","RegisterTemplate",tmp)
    end
```

end)

---
**PyroFire (mod author):** Confirmed issue, implement this proposed 'fix' at risk to your own risk to your save files; No guarantees can be offered there.
I suspect the most foreseeable conflicts with this 'fix' can be easily solved in migration to the next version, but I have not completed fixes for this yet therefore there are no guarantees; it is always best to wait for official updates and fixes instead of running amuck with your mod files which always carries inherent risk of corrupting your save files in the process regardless of the mods attached to it.

---
**Vo2MaxCoding:** Unfortunately this workaround does not work for me. I execute the command but nothing happens. But also there is no error message ...

So how can this mod be played? Warptorio requires Alien Biomes and this causes the trees to miss?

---
**Vo2MaxCoding:** Okay I tried around a bit and found a solution:
I used Space Exploration before (not in combination) but SE alters the settings of Alien Biomes. So I reverted them all to default.
This still left the grassy planets without trees. But I used the workaround described by elanu and also added to commented special planet types to the command. This fixed the issue.
Thank you :)

---
**MoroseToad:** I've put @elanu's code into a mod until the fix is made in Warptorio - <https://mods.factorio.com/mod/warptorio2-tree-fix>

---
**PyroFire (mod author):** > I've put @elanu's code into a mod until the fix is made in Warptorio - <https://mods.factorio.com/mod/warptorio2-tree-fix>

Thank you for this fix. I will look into this and check out implementations over the coming days. Merry Christmas.
