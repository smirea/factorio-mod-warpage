# Event on_nth_tick(30) has no destination

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/679a6bb27556ccbf5fab5040
- Thread ID: 679a6bb27556ccbf5fab5040
- Started by: mikelat

---
**mikelat (op):** Latest experimental. The save from this thread reproduces it: <https://forums.factorio.com/viewtopic.php?p=660705>

After the devs patched a c++ error, it now throws:

The mod Warp Drive Machine (0.9.24) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
command has no destination.
stack traceback:
[C]: in function 'set\_multi\_command'
**Warp-Drive-Machine**/control-pirates.lua:282: in function 'PIRATE\_heart\_beat'
**Warp-Drive-Machine**/ship-control.lua:663: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:723: in function <**Warp-Drive-Machine**/control.lua:722>

---
**MFerrari (mod author):** fixed. Thanks for the report
