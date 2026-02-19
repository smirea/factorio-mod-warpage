# Does not work with skins

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/676154e2c6ccda86b04eaa9b
- Thread ID: 676154e2c6ccda86b04eaa9b
- Started by: X_DeathHack_X

---
**X_DeathHack_X (op):** Here is the first mistake:

The Warp Drive Machine mod (0.9.16) caused a fatal error.
Please report this error to the author of the mod.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
The miniMAXIme mod: Scaling and Character Selection (2.0.8) caused an unavoidable error.
Please report this error to the mod's author.

Error while running event minime::on\_post\_entity\_died (ID 145)
**Pi-C\_lib**/libs/assertions.lua:228: Wrong argument! nil is not a valid corpse prototype name!
stack traceback:
[C]: in function 'error'
**Pi-C\_lib**/libs/assertions.lua:228: in function 'arg\_err'
**minime**/scripts/corpse.lua:496: in function 'event\_handler'
**minime**/scripts/events.lua:298: in function <**minime**/scripts/events.lua:295>
stack traceback:
[C]: in function 'set\_tiles'
**Warp-Drive-Machine**/warp-control.lua:728: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:578: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:722: in function <**Warp-Drive-Machine**/control.lua:721>

The mod that caused the error:
<https://mods.factorio.com/mod/gear-girl>

There are no mistakes with the rest of the skin mods, the character just dies during warp.

Example:
<https://mods.factorio.com/mod/MechanicusMiniMAX>
