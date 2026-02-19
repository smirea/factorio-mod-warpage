# changing character kills you

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6754a7b16a830b97322340ba
- Thread ID: 6754a7b16a830b97322340ba
- Started by: ak86

---
**ak86 (op):** using minime to change character to mechanicus kills you when ship warps from planet, if you are on space platform/ground floor
doesnt kill you if you are on any other floors or space station or if you change back to engineer

---
**glektarssza:** I believe this is because of a coding error.

On line `1601` of `warp-control.lua` (mod version 1.0.14 at time of writing) you'll find this code:

```
if source.name=='character' and source.player then
```

This check is incorrect and should read:

```
if source.type=='character' and source.player then
```

This will correctly warp any characters owned by a player with the ship that is leaving, even if they are modded. Changing this in your local copy should ensure that this bug no longer occurs.

**NOTE:** I do not encourage changing your mod locally. You run the following risks by doing so

1. You will not be able to play multiplayer with anyone lacking the identical changes to you.
2. Any crashes resulting in lost playtime/data are your own issue and support from the mod author is at their discretion.

---
**MFerrari (mod author):** addin this fix. thanks

---
**glektarssza:** Thanks for the fix! Cheers!
