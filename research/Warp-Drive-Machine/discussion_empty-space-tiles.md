# empty-space tiles

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/689fc780cc066d92b9329f23
- Thread ID: 689fc780cc066d92b9329f23
- Started by: Stargateur

---
**Stargateur (op):** Mods that add empty-space for compatibility reason make some weird map generation:

![](https://i.imgur.com/555BFNY.png)

I fix it doing:

```
local empty_space = data.raw.tile["empty-space"]

empty_space.trigger_effect = nil
empty_space.effect = nil
empty_space.autoplace = {
  probability_expression = "min(-1000,-2000)",
  default_enabled = false,
}
```

That so hacky I more or less copy what you did for your "space" tile.
