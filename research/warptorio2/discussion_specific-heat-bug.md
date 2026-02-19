# Specific Heat Bug

- URL: https://mods.factorio.com/mod/warptorio2/discussion/657f177bfa15d6859d467950
- Thread ID: 657f177bfa15d6859d467950
- Started by: PyroFire

---
**PyroFire (op) (mod author):** Something about the specific heat of the warp reactor to warp pipes being mis-aligned.

> Code parts:
> current(bugged)
> -- The Reactor Itself
> local t=ExtendDataCopy("reactor","nuclear-reactor",{name="warptorio-reactor",max\_health=5000,neighbour\_bonus=12,consumption="160MW",
> energy\_source={fuel\_category="warp"},heat\_buffer={specific\_heat="10MJ",max\_temperature=1000}, light={ intensity=10, size=9.9, shift={0.0,0.0}, > color={r=1.0,g=0.0,b=0.0} },
>
> fixed:
> -- The Reactor Itself
> local t=ExtendDataCopy("reactor","nuclear-reactor",{name="warptorio-reactor",max\_health=5000,neighbour\_bonus=12,consumption="160MW",
> energy\_source={fuel\_category="warp"},heat\_buffer={specific\_heat="1MJ",max\_temperature=1000}, light={ intensity=10, size=9.9, shift={0.0,0.0}, > color={r=1.0,g=0.0,b=0.0} },

---
**Callaren:** I noticed a few days ago that the warp reactor didn't go above ~502 degrees and using it for power wasn't worth it. Does this fix that issue?

---
**Knofbath:** It does, but there is a competing fix that makes them work properly without needing to alter the specific\_heat. You can use this in the meantime by unzipping the mod and editing data\_warptorio.lua as shown.

---
**PyroFire (op) (mod author):** Added to 1.3.11
