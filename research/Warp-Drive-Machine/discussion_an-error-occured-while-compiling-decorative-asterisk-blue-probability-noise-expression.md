# An error occured while compiling "decorative:asterisk-blue:probability" noise expression

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6843a7f36d5ee3f1662ddd3a
- Thread ID: 6843a7f36d5ee3f1662ddd3a
- Started by: Trollseidon

---
**Trollseidon (op):** The mod Warp Drive Machine (0.9.45) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
An error occured while compiling "decorative:asterisk-blue:probability" noise expression:
NoiseExpression cannot be NaN: multioctaveNoise[3]
stack traceback:
[C]: in function 'create\_surface'
**Warp-Drive-Machine**/warp-control.lua:562: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>
