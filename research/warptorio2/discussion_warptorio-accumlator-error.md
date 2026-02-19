# warptorio-accumlator error

- URL: https://mods.factorio.com/mod/warptorio2/discussion/66f444854188416e53489696
- Thread ID: 66f444854188416e53489696
- Started by: Ziron999

---
**Ziron999 (op):** See screenshot for full error: <https://imgur.com/a/N6lpF5E>

---
**Ziron999 (op):** I found the conflict. For some reason it is incompatible with "Bob's Power Mod". Probably because it has multiple tiers of accumulators. Maybe a patch to allow both?

---
**Ziron999 (op):** can this be moved to the bug thread? my mistake...

---
**PyroFire (mod author):** Based on discord discussion I can confirm this is an issue with other mods. Compatibility will be added, however the primary burden remains on the conflicting mod to supply data tables compliant with vanilla factorio.

In short; the other mod removed icon\_size from some default data table entries which later caused errors in other mods that rely on the base data table.
A seemingly simple fact, but warptorio probably isn't the only one.
It is always better that the originating mod causing the issue be fixed for proper compliance with vanilla factorio.
