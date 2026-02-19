# warp reactor heatpipe

- URL: https://mods.factorio.com/mod/warptorio2/discussion/646e46d9225f8dc82fa0a26e
- Thread ID: 646e46d9225f8dc82fa0a26e
- Started by: chingis_khagan

---
**chingis_khagan (op):** Placing warp heatpipes seems to prevent the warp reactor temperature from rising above about 502°C. Perhaps I haven't understood how they are intended to be used, but if the purpose is to allow you to set up heat exchangers on a different platform, then this behaviour seems to be a bug that renders them useless.

---
**chingis_khagan (op):** The warp heatpipe severely reduces the energy output of the reactor to the extent that it's fully consumed by a single heat exchanger. This has to be a bug.

Edit: the culprit is the specific heat capacity — since it is only 1/10th that of the reactor, when the heat of both the reactor and heatpipe is auto-balanced, 90% of the energy which should have been transferred from the reactor to the heatpipe is simply lost. I increased the specific heat of the warp heat pipe to 10MJ (equal to the reactor) which fixes the energy-draining behaviour, but the better solution would be to autobalance temperature\*specific\_heat.

---
**chingis_khagan (op):** I found the following solution, changing AutoBalanceHeat() so that it calculates a temperature average weighted by specific heat. The result is all entities having the same temperature without any energy loss.

function entity.AutoBalanceHeat(t) -- Auto-balance heat between all entities in a table
local e=0 sh=0 tsh=0
for k,v in pairs(t)do sh=v.prototype.heat\_buffer\_prototype.specific\_heat e=e+v.temperature\*sh tsh=tsh+sh end
for k,v in pairs(t)do v.temperature=e/tsh end
end

---
**Quezler:** wrote this since i ran into it too: <https://mods.factorio.com/mod/warptorio2-warp-heatpipe-specific-heat>

---
**PyroFire (mod author):** > wrote this since i ran into it too: <https://mods.factorio.com/mod/warptorio2-warp-heatpipe-specific-heat>

Thanks for that.
This needs some looking into.

---
**Knofbath:** Yeah, the intent was that the reactor has a higher thermal mass. Which is what I assumed the specific\_heat did.

~~The way that vanilla uses it, is that 1'C = 1'C for transfer purposes, and ignores specific\_heat. A vanilla heat pipe and reactor are both specific\_heat="1MJ". And the specific\_heat is only used on the producer/consumer side to convert degrees Celsius to Joules...~~  Vanilla doesn't have a problem with this, I misspoke.

The warp reactor changes in 1.3.9 > 1.3.10 changed specific\_heat from 4MJ to 10MJ, while also increasing the reactor output from 20MW to 160MW. So, nobody noticed the 4:1 loss before, because you were only going from 20MW > 5MW output. But you notice a 10:1 reduction of 160MW > 16MW a lot more. (And I never noticed it in testing the changes, because it says 160MW on the reactor, and I was running like a 4GW reactor setup, so losing 144MW wasn't a noticeable blip.)

I do think chingis\_khagan's changes are better than just force-equalizing the specific\_heat of all entities. ~~But they should probably be pushed upstream to base Factorio. The workaround for the mod is just changing the specific\_heat back to "1MJ" in the warp reactor definition(data\_warptorio.lua, line 136).~~ PyroFire needs to update lib\_control.lua, since this is only an issue with the warp heat pipes and AutoBalancer function.

---
**PyroFire (mod author):** Added this to 1.3.11
