# Garden floor research crashed whole game

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/6996443bab1e765bc9865c16
- Thread ID: 6996443bab1e765bc9865c16
- Started by: Maridka

---
**Maridka (op):** Hello, after researching garden floor I did not get it (wasn't created after few warps after too)

<https://imgur.com/a/uwZntln>

Then after 2/3 warps game gives error above :/ Can't play without garden anyway (to get next lvl reserach perhaps) cause game will crash anyway. (I'm stuck in space there is no planet to teleport too)

---
**Maridka (op):** So I vibe coded with chat gpt and it helped me move on to the next areas without getting stuck.
Now the only problem is the lack of a garden level – I'll play and research gardenplatformupgrade2 and see what happens.

Change control.lua where 'on\_tick\_power()' is.
"

local function on\_tick\_power()
if not storage.warptorio or not storage.warptorio.power then return end

local p1 = storage.warptorio.power[1]
local p2 = storage.warptorio.power[2]
local p3 = storage.warptorio.power[3]

if not (p1 and p1.valid and p2 and p2.valid) then
return
end

local ave = (p1.energy + p2.energy) / 2

if p3 and p3.valid then
ave = (p1.energy + p2.energy + p3.energy) / 3
end

p1.energy = ave
p2.energy = ave

if p3 and p3.valid then
p3.energy = ave
end
end

"

Also that is not the sollution because after few warps: (note that my garden floor is missing also)

Error while running event warptorio-space-age::on\_gui\_click (ID 1)
**warptorio-space-age**/control.lua:209: attempt to index field '?' (a nil value)
stack traceback:
**warptorio-space-age**/control.lua:209: in function 'get\_or\_create'
**warptorio-space-age**/control.lua:431: in function 'refresh\_power\_and\_teleport'
**warptorio-space-age**/control.lua:1499: in function 'next\_warp\_zone\_space'
**warptorio-space-age**/control.lua:1548: in function 'next\_warp\_zone'
**warptorio-space-age**/control.lua:1819: in function <**warptorio-space-age**/control.lua:1776>

And if you want visit garden floor:

Error while running event warptorio-space-age::on\_tick (ID 0)
**warptorio-space-age**/control.lua:993: attempt to index field '?' (a nil value)
stack traceback:
**warptorio-space-age**/control.lua:993: in function 'check\_teleport'
**warptorio-space-age**/control.lua:1754: in function <**warptorio-space-age**/control.lua:1669>

I guess something gone bad after gardefloor research, saddly cant reverse it so in future will have to play new save :(

---
**Venca123 (mod author):** Can you send me full mod list so I can look into what went wrong?

---
**Maridka (op):** Like this?

<https://imgur.com/a/fSgYmH0>
