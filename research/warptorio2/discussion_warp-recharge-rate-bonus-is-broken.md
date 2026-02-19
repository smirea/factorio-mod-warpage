# Warp Recharge Rate bonus is broken

- URL: https://mods.factorio.com/mod/warptorio2/discussion/62781d07981aedd06c431ceb
- Thread ID: 62781d07981aedd06c431ceb
- Started by: Gorfiend7

---
**Gorfiend7 (op):** Getting the first level of Warp Reactor breaks the cooldown rate of the Warp Charge. Normally the charge time is reduced every few seconds, but after the research it is very rarely reduced.

The issue appears to be with warptorio.ChargeCountdownTick. There is a `if(tick%(r*5)==0)` check, but it is only registered to be called every 300 ticks, so `tick` is always a multiple of 300. With no reactor upgrades, `r*5` is also 300 so the check always passes, but after an upgrade `r*5` becomes something else (285 for the first level), which will only pass the check very rarely.

---
**PyroFire (mod author):** Confirmed bug.

This has already been fixed for the next pending update.
Your diagnosis is correct, the on\_tick timer is out of sync because of misaligned common denominators.

This also results in a somewhat insignificant balance "change", where the manual-warp timer will now tick down at 13 seconds for each second, and becoming 1sec faster per reactor level.
