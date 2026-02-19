# 2.0.27 Error

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/676376c142854b9c85fbec00
- Thread ID: 676376c142854b9c85fbec00
- Started by: Durikkan

---
**Durikkan (op):** Seemingly this mod did not like the factorio/space age version 2.0.27 changes related to gleba. -- edit : Or I guess it's technically the library, but required for this mod so probably works here too.

Failed to load mods: **mferrari\_lib**/prototypes/gleba\_enemy\_variants.lua:21: attempt to index field 'absorptions\_per\_second' (a nil value)
stack traceback:
**mferrari\_lib**/prototypes/gleba\_enemy\_variants.lua:21: in function 'make\_bm\_gleba\_spawner'
**mferrari\_lib**/prototypes/gleba\_enemy\_variants.lua:40: in main chunk
[C]: in function 'require'
**Warp-Drive-Machine**/data.lua:62: in main chunk

---
**MFerrari (mod author):** fixed
