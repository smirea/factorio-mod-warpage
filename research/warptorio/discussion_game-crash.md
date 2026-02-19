# Game Crash

- URL: https://mods.factorio.com/mod/warptorio/discussion/5d15fb17fb111e000d6903f5
- Thread ID: 5d15fb17fb111e000d6903f5
- Started by: KrazyTygr

---
**KrazyTygr (op):** I've got the following game crash:
The mod Lane Balancer caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Lane-Balancer::on\_tick (ID 0)
LuaSurface API call when LuaSurface was invalid.
stack traceback:
**Lane-Balancer**/control.lua:128: in function 'GetBalancerInBelt'
**Lane-Balancer**/control.lua:221: in function 'OnTick'
**Lane-Balancer**/control.lua:10: in function <**Lane-Balancer**/control.lua:10>
stack traceback:
[C]: in function '**index'
\_\_Lane-Balancer**/control.lua:128: in function 'GetBalancerInBelt'
**Lane-Balancer**/control.lua:221: in function 'OnTick'
**Lane-Balancer**/control.lua:10: in function <**Lane-Balancer**/control.lua:10>

I know that Lane Balancer is causing the crash, but it may be affected by the way in which Warptorio removes/replaces the surface, so I've posted in both places.
