# Planet Template bug

- URL: https://mods.factorio.com/mod/warptorio2/discussion/62261ca6b671a97f4663da68
- Thread ID: 62261ca6b671a97f4663da68
- Started by: PyroFire

---
**PyroFire (op) (mod author):** This has been a long standing bug which has been reported many times.
I haven't been able to figure out the cause.

Reports:
<https://mods.factorio.com/mod/warptorio2/discussion/6172d750d316fc71e8948d19>
<https://mods.factorio.com/mod/warptorio2/discussion/6127699ff8407ea741d4150f>
<https://mods.factorio.com/mod/warptorio2/discussion/608200bbef2927446603b8f7>
<https://mods.factorio.com/mod/warptorio2/discussion/5edb8ffe472fe4000d53b631>
<https://mods.factorio.com/mod/warptorio2/discussion/600de77e44d7bef892347cc6>

Convenient list of relevant errors:

<https://mods.factorio.com/mod/warptorio2/discussion/6172d750d316fc71e8948d19>

```
The mod Warptorio2 Expansion (1.1.69) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2_expansion::Custom event (ID 210)
warptorio2_expansion/control.lua:50: table index is nil
stack traceback:
warptorio2_expansion/control.lua:50: in function 'update_planet_info'
warptorio2_expansion/control.lua:101: in function 'on_warptorio_warp'
warptorio2_expansion/control.lua:379: in function <warptorio2_expansion/control.lua:378>
stack traceback:
[C]: in function 'raise_event'
warptorio2/lib/lib_control.lua:258: in function 'vraise'
warptorio2/control_main.lua:872: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:281: in function <warptorio2/lib/lib_control.lua:281>
```

<https://mods.factorio.com/mod/warptorio2/discussion/6127699ff8407ea741d4150f>

```
8615.760 Error MainLoop.cpp:1285: Exception at tick 5143740: The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on_tick (ID 0)
warptorio2/control_main.lua:936: attempt to concatenate field 'name' (a table value)
stack traceback:
warptorio2/control_main.lua:936: in function 'WarpBuildPlanet'
warptorio2/control_main.lua:848: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:281: in function <warptorio2/lib/lib_control.lua:281>
```

<https://mods.factorio.com/mod/warptorio2/discussion/608200bbef2927446603b8f7>

```
The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on_tick (ID 0)
Error when running interface function planetorio.FromTemplate: planetorio/control_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
planetorio/control_planets.lua:168: in function 'Generate'
planetorio/control_planets.lua:216: in function <planetorio/control_planets.lua:214>
stack traceback:
[C]: in function 'call'
warptorio2/control_main.lua:940: in function 'WarpBuildPlanet'
warptorio2/control_main.lua:848: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:281: in function <warptorio2/lib/lib_control.lua:281>
```

<https://mods.factorio.com/mod/warptorio2/discussion/5edb8ffe472fe4000d53b631>

```
The mod Warptorio2 (1.2.8) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on_tick (ID 0)
Error when running interface function planetorio.FromTemplate: planetorio/control_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
planetorio/control_planets.lua:168: in function 'Generate'
planetorio/control_planets.lua:216: in function <planetorio/control_planets.lua:214>
stack traceback:
warptorio2/control_main.lua:896: in function 'WarpBuildPlanet'
warptorio2/control_main.lua:804: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:280: in function <warptorio2/lib/lib_control.lua:280>
stack traceback:
[C]: in function 'call'
warptorio2/control_main.lua:896: in function 'WarpBuildPlanet'
warptorio2/control_main.lua:804: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:280: in function <warptorio2/lib/lib_control.lua:280>
```

<https://mods.factorio.com/mod/warptorio2/discussion/600de77e44d7bef892347cc6>

```
The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on_tick (ID 0)
Error when running interface function planetorio.FromTemplate: planetorio/control_planets.lua:168: attempt to index local 'planet' (a nil value)
stack traceback:
planetorio/control_planets.lua:168: in function 'Generate'
planetorio/control_planets.lua:216: in function <planetorio/control_planets.lua:214>
stack traceback:
[C]: in function 'call'
warptorio2/control_main.lua:940: in function 'WarpBuildPlanet'
warptorio2/control_main.lua:848: in function 'Warpout'
warptorio2/control_main_helpers.lua:227: in function 'b'
warptorio2/lib/lib_control.lua:281: in function <warptorio2/lib/lib_control.lua:281>
```

---
**ccsla:** Hi Pyro!
Thank you for the update!

So, I was reading your notes here, and went digging a bit.
And I may have find a typo that could explain theses reports (again :p).

In *Planetorio* (v*0.1.3*), in *control\_planets.lua*, line *131*:
shouldn't:
events.vraise("*on\_templated\_removed*",{template=tmp})
be:
events.vraise("*on\_template\_removed*",{template=tmp})
?

Hope this helps!

---
**PyroFire (op) (mod author):** > So, I was reading your notes here, and went digging a bit.
> And I may have find a typo that could explain theses reports (again :p).

Hey, thanks for this.
This typo is very likely to be causing the reported issues under certain circumstances.

---
**ccsla:** Always glad to help!

---
**OverLucker:** I know this is old, but seems actual

I've warped to rest\_beach and set it as homeworld. I placed rocket silo and some warp linked chests. Now i can't get back to the homeworld.

Caught error:
The mod Warptorio2 (1.3.9) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
**warptorio2**/control\_main.lua:938: attempt to concatenate field 'name' (a table value)
stack traceback:
**warptorio2**/control\_main.lua:938: in function 'WarpBuildPlanet'
**warptorio2**/control\_main.lua:850: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

Factorio version == 1.1.61 (build 59839, win64)
Mod list:
- Alien biomes==0.6.7
- Alien biomes High-res Terrain==0.6.1
- Base mod==1.1.61
- Bullet Trails==0.6.2
- Combat mechanics overhaul==0.6.22
- Explosive biters==1.1.36
- Factorio crash site==1.0.2
- Factorio library==0.8.3
- Frost biters==1.1.2
- Planetorio==0.1.3
- Planetorio Expansions Planets==1.0.3
- Warptorio2==1.3.9
- Warptorio2 Expansion==1.1.87

---
**OverLucker:** When i choose "Nauvis" it crashes other way. Mods and version same as in previous post

The mod Warptorio2 Expansion (1.1.87) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2\_expansion::Custom event (ID 189)
**warptorio2\_expansion**/control.lua:54: table index is nil
stack traceback:
**warptorio2\_expansion**/control.lua:54: in function 'update\_planet\_info'
**warptorio2\_expansion**/control.lua:108: in function 'on\_warptorio\_warp'
**warptorio2\_expansion**/control.lua:408: in function <**warptorio2\_expansion**/control.lua:407>
stack traceback:
[C]: in function 'raise\_event'
**warptorio2**/lib/lib\_control.lua:258: in function 'vraise'
**warptorio2**/control\_main.lua:874: in function 'Warpout'
**warptorio2**/control\_main\_helpers.lua:227: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (op) (mod author):** > I know this is old, but seems actual
>
> I've warped to rest\_beach and set it as homeworld. I placed rocket silo and some warp linked chests. Now i can't get back to the homeworld.

this is unrelated to the subject of this thread.
Refer to here: <https://mods.factorio.com/mod/warptorio2/discussion/630e12ed4d19d61d4c4cfdf8>

> When i choose "Nauvis" it crashes other way. Mods and version same as in previous post

Expansion issue, add it to existing bug report here: <https://mods.factorio.com/mod/warptorio2_expansion/discussion/6302cd2e863061fe6d70371c>
