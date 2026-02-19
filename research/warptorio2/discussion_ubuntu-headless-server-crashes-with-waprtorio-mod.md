# Ubuntu headless server crashes with waprtorio mod

- URL: https://mods.factorio.com/mod/warptorio2/discussion/61474e9d3131588a47f4e253
- Thread ID: 61474e9d3131588a47f4e253
- Started by: x34

---
**x34 (op):** Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 [7.043 Error ServerMultiplayerManager.cpp:91: MultiplayerManager failed: "The mod Warptorio2 (1.3.5) caused a non-recoverable error.]
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: Please report this error to the mod author.
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server:
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: Error while running event warptorio2::on\_init()
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: Invalid surface name: Surface names must not be blank and must be unique.
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: stack traceback:
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011[C]: in function 'create\_surface'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/control\_main.lua:132: in function 'MakePlatformFloor'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/control\_main.lua:157: in function 'GetPlatformFloor'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/control\_main.lua:234: in function 'InitPlatform'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/control\_main.lua:333: in function 'v'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/lib/lib\_control.lua:270: in function 'raise\_migrate'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/control\_main.lua:248: in function 'v'
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: #011\_\_warptorio2\_\_/lib/lib\_control.lua:269: in function <**warptorio2**/lib/lib\_control.lua:269>"
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.043 Info ServerMultiplayerManager.cpp:780: updateTick(4294967295) changing state from(CreatingGame) to(InitializationFailed)
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.043 Info CommandLineMultiplayer.cpp:209: Exit point.
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.051 Info ServerMultiplayerManager.cpp:140: Quitting multiplayer connection.
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.051 Info ServerMultiplayerManager.cpp:780: updateTick(4294967295) changing state from(InitializationFailed) to(Closed)
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.196 Info UDPSocket.cpp:218: Closing socket
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio Server: 7.196 Goodbye
Sep 19 16:45:58 Ubuntu-2004-focal-64-minimal bash[833587]: 2021/09/19 16:45:58 Factorio process exited with error: exit status 1

---
**PyroFire (mod author):** This error is impossible unless you have changed some of the warptorio code or are using other mods that are conflicting with warptorio's surface manager.
But both those cases are equally unlikely.
This is also the first report of any issue (at all) with surface creation at startup, so it is also more likely that the local copy of the mod you are using is corrupt in some way, rather than there being any genuine issues with warptorio.

I suggest altering the code temporarily to add a line to log which surface it is trying to create.
in file "control\_main.lua" under the function warptorio.MakePlatformFloor, add this before the game.create\_surface function: log("Warptorio trying to make surface keyed: " .. vt.key)
