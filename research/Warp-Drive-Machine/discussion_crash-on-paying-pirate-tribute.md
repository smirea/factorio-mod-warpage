# Crash on paying pirate tribute.

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/675d2c0bd29d33ccd2ab048a
- Thread ID: 675d2c0bd29d33ccd2ab048a
- Started by: Sir_AL

---
**Sir_AL (op):** Crashed upon clicking the button to pay tribute to pirates. Had the resources on my ship, but I definitely didn't have them on my person.

Error:

The mod Warp Drive Machine (0.9.14) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_gui\_click (ID 1)
**Warp-Drive-Machine**/ship-control.lua:161: attempt to index field '?' (a nil value)
stack traceback:
**Warp-Drive-Machine**/ship-control.lua:161: in function 'steal\_resources\_from\_ship'
**Warp-Drive-Machine**/gui-control.lua:2104: in function 'bt\_pay\_pirate\_extortion'
**Warp-Drive-Machine**/gui-control.lua:647: in function <**Warp-Drive-Machine**/gui-control.lua:573>
