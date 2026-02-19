# Error when warping to surface

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/64ea08c9d4bd6e31799b9d80
- Thread ID: 64ea08c9d4bd6e31799b9d80
- Started by: FaerarF

---
**FaerarF (op):** Hey

Unrecoverable error upon automatic exit from the 1 minute space travel. Happened randomly on like the 35th or something warp
The mod Warp Drive Machine (0.1.15) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(60)
Error when running interface function planet.FromTemplate: "stone" is not a valid autoplace control name.
stack traceback:
[C]: in function 'create\_surface'
**planetorio**/control\_planets.lua:183: in function 'MakeSurface'
**planetorio**/control\_planets.lua:218: in function <**planetorio**/control\_planets.lua:214>
stack traceback:
[C]: in function 'call'
**Warp-Drive-Machine**/warp-control.lua:334: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:237: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:453: in function <**Warp-Drive-Machine**/control.lua:448>

Edit: Also running Exotic Industries which makes stone not be an ore on the map. Maybe that has something to do with it? Any way around this?

---
**ARGIEJIMP:** i have error too without exotic industries,but i have a lot of other mods who work before this update
btw can you give us water inside the (base)? like warptorio boiler floor

---
**MFerrari (mod author):** I dont think you can play this with Exotic Industries... the crash is caused by the missing stone, removed by Exotic Ind...
EI is not compatible with multiple surfaces
Anyway try to remove planetorio and see if it works.

No plan to add water inside the ship. Water should be considered a resource, and stored on tanks

---
**ARGIEJIMP:** for me still crush when i join the game (im in nauvis) he removes me mining prodactivity 9,laboratory prodactivity 9,projectyle damage 9,character mining speed 9. when i go to space he removes me 1 expansion from every floor and when i go from space to nauvis crush and show me this:
The mod Warp Drive Machine (0.1.17) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(60)
**Warp-Drive-Machine**/warp-control.lua:540: bad argument #0 of 1 to 'rechart' (Wrong number of arguments.)
stack traceback:
[C]: in function 'rechart'
**Warp-Drive-Machine**/warp-control.lua:540: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:254: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:438: in function <**Warp-Drive-Machine**/control.lua:433>

---
**mrfej:** I have a similar issue: (no other mods active.
The mod Warp Drive Machine (0.1.18) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(60)
**Warp-Drive-Machine**/warp-control.lua:541: bad argument #0 of 1 to 'rechart' (Wrong number of arguments.)
stack traceback:
[C]: in function 'rechart'
**Warp-Drive-Machine**/warp-control.lua:541: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:335: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:467: in function <**Warp-Drive-Machine**/control.lua:462>

---
**MFerrari (mod author):** I have no idea why this is happening... do you have a save game before to the crash that is happens after some time ?

---
**ARGIEJIMP:** new game i dont built do nothink just warp it mods:alien biomes 0.6.8,base mod 1.1.80,factorio crush site 1.0.2,space exploration graphics part 1 0.6.15,warp drive machine 0.1.18, game version 1.1.80 crush again :(
The mod Warp Drive Machine (0.1.18) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event Warp-Drive-Machine::on\_nth\_tick(60)
**Warp-Drive-Machine**/warp-control.lua:541: bad argument #0 of 1 to 'rechart' (Wrong number of arguments.)
stack traceback:
[C]: in function 'rechart'
**Warp-Drive-Machine**/warp-control.lua:541: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:335: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:467: in function <**Warp-Drive-Machine**/control.lua:462>

---
**ARGIEJIMP:** i change game version to 1.1.87 and work so i load my old game to see what happend.
old save work too the one where mod removes me 1 expansion from every from i have some tiles out of yellow line with alt mod open :D

---
**MFerrari (mod author):** Humm thats the issue then. The game must be updated. I'm on 1.1.89

---
**ARGIEJIMP:** yep i hope i help cause i like all your mods :)
