# [NEW] Storage Room Crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/675214099bbc8ffe13b7297b
- Thread ID: 675214099bbc8ffe13b7297b
- Started by: kitsune37

---
**kitsune37 (op):** If you try placing any of the four basic "Spaceship tiles" on the "Storage Floor" it causes an error to occur.
To answer the "how did you find this?" question, simply because "I was curios".

The mod Warp Drive Machine (0.9.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_player\_built\_tile (ID 49)
**Warp-Drive-Machine**/control.lua:1368: attempt to index field 'harvesters' (a nil value)
stack traceback:
**Warp-Drive-Machine**/control.lua:1368: in function <**Warp-Drive-Machine**/control.lua:1333>

---
**kitsune37 (op):** > If you try placing any of the four basic "Spaceship tiles" on the "Storage Floor" it causes an error to occur.
> To answer the "how did you find this?" question, simply because "I was curios".
>
> =====================================================
> The mod Warp Drive Machine (0.9.9) caused a non-recoverable error.
> Please report this error to the mod author.
>
> Error while running event Warp-Drive-Machine::on\_player\_built\_tile (ID 49)
> **Warp-Drive-Machine**/control.lua:1368: attempt to index field 'harvesters' (a nil value)
> stack traceback:
> **Warp-Drive-Machine**/control.lua:1368: in function <**Warp-Drive-Machine**/control.lua:1333>
> =====================================================

---
**MFerrari (mod author):** fixed
