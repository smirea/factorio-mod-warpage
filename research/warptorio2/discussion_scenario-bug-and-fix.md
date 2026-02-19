# Scenario bug and fix

- URL: https://mods.factorio.com/mod/warptorio2/discussion/643ffe333abf8ccfeb0996ff
- Thread ID: 643ffe333abf8ccfeb0996ff
- Started by: Faryu

---
**Faryu (op):** Converting a warptorio2 save to a scenario caused an error.
Creating a new scenario works and saving it does as well. But loading it afterwards causes the same error.

I have fixed the part that causes the error and am now wondering, where to put the fix. I would have created a pull request on the github, but it seems to be a bit behind. Last commit >2 years.

The fix is to add the following in lib\_control\_cache.lua:
function cache.destroy\_type(obj,...)
if obj == nil then return end
if type(obj.is\_player) == "function" and obj.is\_player() then return end
local vtype=obj.type
....

---
**PyroFire (mod author):** what is the error?

---
**Faryu (op):** Sorry for the late reply.
I tried to convert it just now, my Save to a Scenario and I got this error:

The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_pre\_player\_removed (ID 138)
LuaPlayer doesn't contain key type.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/lib/lib\_control\_cache.lua:198: in function <**warptorio2**/lib/lib\_control\_cache.lua:198>
(...tail calls...)
**warptorio2**/control\_main.lua:453: in function 'tx'
**warptorio2**/lib/lib\_control\_cache.lua:161: in function 'call\_player'
**warptorio2**/lib/lib\_control\_cache.lua:555: in function 'y'
**warptorio2**/lib/lib\_control.lua:289: in function <**warptorio2**/lib/lib\_control.lua:289>

---
**Aqo:** I'm running into the same error.
This prevents me from hosting a multiplayer warptorio2 game on factorio.zone, and it also prevents me from converting a save into a scenario to test stuff in the map editor.

Steps to reproduce:
1. Disable all mods (other than Base mod) and then enable Warptorio2 (1.3.10) which will also enable Planetorio (0.1.5) as a dependency
2. Single player -> New game -> Freeplay -> Next -> Play
3. Tab to skip intro -> Esc -> Save game -> Save as [warptorio-test-filename] -> Quit game
4. (main menu) Map editor -> Convert save -> Select [warptorio-test-filename] -> Convert

Then you will get this error: <https://i.imgur.com/1UzUrxc.png>
Error while running event warptorio2::on\_pre\_player\_removed (ID 138)
LuaPlayer doesn't contain key type.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/lib/lib\_control\_cache.lua:198: in function
...
in function 'tx'
in function 'call\_player'
in function 'y'
in function
...

I tried doing what Faryu suggested, edited lib/lib\_control\_cache.lua, replaced:

function cache.destroy\_type(obj,...) local vtype=obj.type
local c=cache[vtype] if(not c)then return end if(obj.name)then c=c[obj.name] if(not c)then return end end
if(c.unraise)then c.unraise(obj,...) end
global.\_lib[vtype][obj.index]=nil
if(obj.hostindex)then global.\_lib[vtype.."\_idx"][obj.hostindex]=nil end
end

with

function cache.destroy\_type(obj,...)
if obj == nil then
return
end
if type(obj.is\_player) == "function" and obj.is\_player() then
return
end
local vtype=obj.type
local c=cache[vtype]
if(not c) then
return
end
if(obj.name) then
c=c[obj.name]
if(not c) then
return
end
end
if(c.unraise) then
c.unraise(obj,...)
end
global.\_lib[vtype][obj.index] = nil
if(obj.hostindex) then
global.\_lib[vtype.."\_idx"][obj.hostindex] = nil
end
end

and although this allowed me to convert the save into a scenario and open it in the map editor, which by defaults opens it paused, as soon as I unpause, it crashes with a different error: <https://i.imgur.com/UqqkXqv.png>

warptorio2::on\_tick (ID 0)
LuaGuiElement API call when LuaGuiElement was invalid.
in function \_\_newindex
in function ?
in function call\_menu
in function updatemenu
in function b
...

Would it be possible to fix this so that I could show warptorio2 to more friends and play together in multiplayer? I think the mod is very fun

---
**PyroFire (mod author):** Todo: Scenario related issue.
