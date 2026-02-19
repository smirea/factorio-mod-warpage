# Please don't use `string.match` to check for technology

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/6824f0f1393d33b714ca6d4d
- Thread ID: 6824f0f1393d33b714ca6d4d
- Started by: PennyJim

---
**PennyJim (op):** If we just *happen* to have `warp` and any other keyword in the technology name, it'll error. This is unbearable

At a minimum, please just check if the warp is specifically at the beginning of the string with

```
if research_name:sub(1, 6) ~= "warp-" then return end
```

If you're okay, here's a drop in replacement for the handler I did because it bothered me so much.
It means the naming structure is more strict ("warp-<keyword>-<more>"), but I only see that as a positive

```
local technology = {
    ["ground"] = update_ground_platform,
    ["factory"] = update_factory_platform,
    ["biochamber"] = update_biochamber_platform,
    ["power"] = update_power,
    ["time"] = update_time,
    ["belt"] = update_belt,
    ["container"] = function (name)
        game.print("Container will be added after the teleport")
        local side = name:sub(16)
        if side == "left" then
            storage.warptorio.container_left_enabled = true
        elseif side == "right" then
            storage.warptorio.container_right_enabled = true
        end
    end,
    ["end"] = function (name)
        local stage = name:sub(10)
        if stage ~= "win" then return end

        game.set_win_ending_info{title={"warptorio.end-screen-title"}, message={"warptorio.end-screen-text"}}
        game.set_game_state{game_finished=true,player_won=true,can_continue=true}
    end,
}
script.on_event(defines.events.on_research_finished, function(e)
    local base_name = e.research.name --[[@as string]]
    if base_name:sub(1, 5) ~= "warp-" then return end

    local name = base_name:sub(6)
    name = name:sub(1, name:find("-") - 1)

    local handler = technology[name]
    if handler then handler(base_name) end
end)
```

---
**Venca123 (mod author):** Thank you. There are few more issues that are really bad like this one. I was planning to fix them once I am happy with the main loop, still thanks I will fix it a bit differently, but it will be fixed asap
