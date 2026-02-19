# Error when warping

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/682ceb53d90d390910f78106
- Thread ID: 682ceb53d90d390910f78106
- Started by: Lucianus

---
**Lucianus (op):** The mod Warp Drive Machine (0.9.41) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:380: attempt to index field 'autoplace\_controls' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:380: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:503: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:747: in function <**Warp-Drive-Machine**/control.lua:746>

---
**MFerrari (mod author):** try updating the mod

---
**Lucianus (op):** Updated. Samer error:
The mod Warp Drive Machine (0.9.42) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:380: attempt to index field 'autoplace\_controls' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:380: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:503: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:747: in function <**Warp-Drive-Machine**/control.lua:746>

---
**MFerrari (mod author):** fixed

---
**emerge.f:** Мод Warp Drive Machine (0.9.43) вызвал неустранимую ошибку.
Пожалуйста, сообщите об этой ошибке автору мода.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:124: attempt to index field '?' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:124: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:504: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>

---
**Wwombatt:** Same:
The mod Warp Drive Machine (0.9.43) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:124: attempt to index field '?' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:124: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:504: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>

---
**Wwombatt:** Might be happening when in space, and you remove/move a building (turret, other) from one place to another.

---
**MFerrari (mod author):** playing with other planets ? maybe this is an issue related ..
I'm releasing a new version... please try it

---
**djmalk:** The mod Warp Drive Machine (0.9.44) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/warp-control.lua:60: attempt to index local 'autoplace\_control' (a nil value)
stack traceback:
**Warp-Drive-Machine**/warp-control.lua:60: in function 'check\_non\_zero\_control'
**Warp-Drive-Machine**/warp-control.lua:386: in function 'get\_new\_random\_planet'
**Warp-Drive-Machine**/warp-control.lua:509: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>

map\_gen\_settings["base\_planet"] = "nauvis-factory-floor"

It seems that ship is trying to warp to the Factorissimo factory floor.
If Factorissimo2 is not supported, it should be added to the list of mod conflicts or you get reports like this :D
Cool mod — thanks for your contribution!

---
**MFerrari (mod author):** > The mod Warp Drive Machine (0.9.44) caused a non-recoverable error.
> Please report this error to the mod author.
>
> Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
> **Warp-Drive-Machine**/warp-control.lua:60: attempt to index local 'autoplace\_control' (a nil value)
> stack traceback:
> **Warp-Drive-Machine**/warp-control.lua:60: in function 'check\_non\_zero\_control'
> **Warp-Drive-Machine**/warp-control.lua:386: in function 'get\_new\_random\_planet'
> **Warp-Drive-Machine**/warp-control.lua:509: in function 'warp\_now'
> **Warp-Drive-Machine**/ship-control.lua:603: in function 'update\_ships\_each\_second'
> **Warp-Drive-Machine**/control.lua:746: in function <**Warp-Drive-Machine**/control.lua:745>
>
> map\_gen\_settings["base\_planet"] = "nauvis-factory-floor"
>
> It seems that ship is trying to warp to the Factorissimo factory floor.
> If Factorissimo2 is not supported, it should be added to the list of mod conflicts or you get reports like this :D
> Cool mod — thanks for your contribution!

please show me the link to this Factorissimo2 mod you are using.. I'm gonna check if this is the cause

---
**djmalk:** <https://mods.factorio.com/mod/factorissimo-2-notnotmelon?from=search>
I disabled it and no more crashes, u can't build on factory floors any way with your mod, so factorissimo is usless with your mod.
