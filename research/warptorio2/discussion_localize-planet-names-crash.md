# localize planet names + crash

- URL: https://mods.factorio.com/mod/warptorio2/discussion/630e12ed4d19d61d4c4cfdf8
- Thread ID: 630e12ed4d19d61d4c4cfdf8
- Started by: PyroFire

---
**PyroFire (op) (mod author):** control\_main.lua:938 in function warptorio.WarpBuildPlanet incorrect game.print invocation. hp.name should be a localised string.

There are also some modded planets which treat the template name like a localised string when this is not expected and causes crashes.

`game.print({"",{"planet-name." .. hp.key},{"planetorio.home_sweet_home_text"}})`

however it might be more prudent to permit both approaches, so the name can either be a string or a localised string on its own.

`game.print({"",hp.name,{"planetorio.home_sweet_home_text"}})`

without either change, crashes happen if names are localised strings if that planet is made a homeworld.
Although this does not exist in base warptorio, it does in the expansion.

<https://mods.factorio.com/mod/planetorio_expansion_planets/discussion/5f33bd4ba1016062c165a852>

issue raised here <https://github.com/PyroFire232/warptorio2/pull/15>

---
**PyroFire (op) (mod author):** fixed for next version
