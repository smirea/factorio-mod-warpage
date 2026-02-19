# Unknown technology "tanks"

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5fcae62523a3f47151d02823
- Thread ID: 5fcae62523a3f47151d02823
- Started by: NancyBDrew

---
**NancyBDrew (op):** When "Warp Harvester Floor" research completed, I got the following error:

The mod Warptorio2 (1.3.3) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_research\_finished (ID 18)
Unknown technology name: tanks
stack traceback:
[C]: in function 'draw\_sprite'
**warptorio2**/control\_class\_teleporter.lua:260: in function 'MakePointSprites'
**warptorio2**/control\_class\_teleporter.lua:229: in function 'MakePointTeleporter'
**warptorio2**/control\_class\_teleporter.lua:177: in function 'CheckTeleporterPairs'
**warptorio2**/control\_class\_teleporter.lua:43: in function '?'
**warptorio2**/control\_class\_teleporter.lua:114: in function 'DoResearchEffects'
**warptorio2**/control\_class\_teleporter.lua:129: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>

---
**PyroFire (mod author):** Damn. Almost all of the technology images were renamed recently. How many more are broken

---
**Eezy:** yeah can't progress at all because of this unfortunately

---
**CaptainSlide:** Yep got it too.
