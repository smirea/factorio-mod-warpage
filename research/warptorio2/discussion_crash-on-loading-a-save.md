# Crash on loading a save

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65f1da9ddb9ddf736302a0fa
- Thread ID: 65f1da9ddb9ddf736302a0fa
- Started by: Giantlobster

---
**Giantlobster (op):** Hi, I get a crash when I try to load a save game:

The mod Warptorio2 (1.3.10) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_configuration\_changed
**warptorio2**/lib/lib\_control.lua:55: attempt to index local 'e' (a nil value)
stack traceback:
**warptorio2**/lib/lib\_control.lua:55: in function 'protect'
**warptorio2**/control\_class\_rails.lua:20: in function 'MakeRails'
**warptorio2**/control\_main.lua:339: in function 'v'
**warptorio2**/lib/lib\_control.lua:270: in function <**warptorio2**/lib/lib\_control.lua:270>

I don't believe any settings are different. I have synced mods with the save. A previous save (that has one of the 4 corner rail transfer things) loads fine. The later save has at least 1 more of them and might have more than that, I can't remember.

Mods:
VehicleSnap 1.18.5
alien-biomes-hr-terrain 0.6.1
bullet-trails 0.6.2
DeathMarkers 0.4.0
even-distribution 1.0.10
far-reach 1.1.3
flib 0.13.0
FNEI 0.4.2
Gun\_Turret\_Alerts 1.1.11
informatron 0.3.4
LandfillEverythingU 1.1.3
manual-inventory-sort 2.2.5
planetorio 0.1.5
stdlib 1.4.8
Timer-map\_playtime 1.1.45
alien-biomes 0.6.8
BottleneckLite 1.2.8
death-log 0.1.2
warptorio2 1.3.10

Is there something I can do to get round this? Let me know if there's any other info that would be useful.
Thanks

---
**Giantlobster (op):** In case it's relevant, this is a multiplayer game but I can't load it single player or multiplayer

---
**Giantlobster (op):** I have found a workaround by changing the mod file. In the function on line 55, I have it only run that if e is not nil. If it is, I have it just return nil. That seems to have loaded fine. I ran a research too so stuff is producing. I also warped to a new planet and that was fine.
I then saved and reloaded using the unmodified mod version and that loaded fine.

Having looked around further, there was a cargo wagon missing from the northwest rail transfer point. I have added that back in and it still loads fine but I might have placed it in a slightly different place.

I then repeated the test quicker: load using my modified version, save immediately, switch to the unmodified version and it loads fine. Hope this helps with working out a fix.

---
**PyroFire (mod author):** > I have found a workaround by changing the mod file. In the function on line 55, I have it only run that if e is not nil. If it is, I have it just return nil. That seems to have loaded fine. I ran a research too so stuff is producing. I also warped to a new planet and that was fine.
> I then saved and reloaded using the unmodified mod version and that loaded fine.
>
> Having looked around further, there was a cargo wagon missing from the northwest rail transfer point. I have added that back in and it still loads fine but I might have placed it in a slightly different place.
>
> I then repeated the test quicker: load using my modified version, save immediately, switch to the unmodified version and it loads fine. Hope this helps with working out a fix.

This is the first report of this issue that I am aware of.

I'm glad you have found a workaround that worked for you, however I confirm that you should always revert the changes you made once you have made your save files working again.
It is a very bad idea to permanently workaround the protect functions as they deliberately throw highly visible errors in the event of uncaught and unhandled exceptions.
If this is still an issue for you, or anyone else, please let me know.
