# Game freezes when jumping to new planet

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/679801d1fa946724faaf2cb1
- Thread ID: 679801d1fa946724faaf2cb1
- Started by: januszkanusz

---
**januszkanusz (op):** After ~70 jumps that work normally, this one makes the app freeze indefinetly. This happened before because of the mods (like fill4me), but this time I don't have any non-essential mods installed. I have a save file I'd be happy to send, as I can reproduce it each time I open it

---
**januszkanusz (op):** I think it tried to go to Gleba for the first time. Here are the logs:

> 38.517 Warning Commander.cpp:211: Enemy entities with auto place controls 'gleba\_enemy\_base' on surface 'gleba' have different collision masks. Enemy expansions may not work properly. Entities: gleba-spawner, gleba-spawner-small, mf-gleba-spawner, mf-gleba-spawner-small
> 62.760 Warning Commander.cpp:211: Enemy entities with auto place controls 'gleba\_enemy\_base' on surface 'gleba' have different collision masks. Enemy expansions may not work properly. Entities: gleba-spawner, gleba-spawner-small, mf-gleba-spawner, mf-gleba-spawner-small
> 74.922 Warning Commander.cpp:211: Enemy entities with auto place controls 'gleba\_enemy\_base' on surface 'gleba' have different collision masks. Enemy expansions may not work properly. Entities: gleba-spawner, gleba-spawner-small, mf-gleba-spawner, mf-gleba-spawner-small
> 81.304 Loading map /Users/user/Library/Application Support/factorio/saves/Warp ship.zip: 1705172 bytes.
> 81.332 Loading level.dat: 11598090 bytes.
> 81.334 Info Scenario.cpp:153: Map version 2.0.32-0
> 81.485 Loading blueprint storage: Local timestamp 1733918386, Cloud timestamp 1733918386
> 81.545 Loading script.dat: 167511 bytes.
> 81.547 Checksum for script **level**/control.lua: 1248072645
> 81.548 Checksum for script **Arachnids\_enemy**/control.lua: 2888443581
> 81.552 Checksum for script **mferrari\_lib**/control.lua: 2433872814
> 81.553 Checksum for script **teleporting\_machine**/control.lua: 3898308594
> 81.554 Checksum for script **turret-activation-delay**/control.lua: 2629497088
> 81.555 Checksum for script **valves**/control.lua: 255970338
> 81.559 Checksum for script **Rocket-Silo-Construction**/control.lua: 1924456466
> 81.559 Checksum for script **alien-biomes**/control.lua: 3316854230
> 81.561 Checksum for script **k2-wind-turbine**/control.lua: 14407157
> 81.561 Checksum for script **Cold\_biters**/control.lua: 1005718152
> 81.562 Checksum for script **k2-wind-turbine-speed**/control.lua: 2396682913
> 81.577 Checksum for script **Warp-Drive-Machine**/control.lua: 3480881756
> 81.580 Applying migration: Valves: 0001-py-valves.lua
> 81.580 Applying migration: Valves: 0002-reduce-combinators.lua
> 81.583 Applying migration: Valves: 0006-reduce-hidden-entities-even-more.lua
> 81.586 Applying migration: Valves: 0007-remove-orphans.lua
> 119.344 Received SIGINT, shutting down
> 120.358 Received SIGTERM, shutting down

---
**MFerrari (mod author):** Is It Mac os ?

---
**januszkanusz (op):** yes

---
**MFerrari (mod author):** this is a problem related to the macos... it does not freeze on windows.. unfortunatelly I cant do much about it

---
**cbusillo:** > After ~70 jumps that work normally, this one makes the app freeze indefinetly. This happened before because of the mods (like fill4me), but this time I don't have any non-essential mods installed. I have a save file I'd be happy to send, as I can reproduce it each time I open it

I have this happen every couple dozen warps. It happens on macOS and Linux. It doesn’t leave any logs and we haven’t found a way to help MFerrari troubleshoot yet.

What I do is open the save in a Windows VM to get past the freeze, or use an autosave more than two minutes before the warp. The freeze is annoying, but I’ve found it worth it to work around.

---
**clifffrey:** I had this happen on one of my first few warps. I got a stack trace using commands below (and can reproduce it with the save that I have). It is potentially worth opening a bug report on the factorio forums, if only to help track it down. One possible theory is that with some terrain generation settings, perhaps there is no guarantee that `surface.force_generate_chunk_requests()` will ever finish (i.e. if on\_chunk\_generated ends up placing entities that overlap the next chunk or something? but this is really just a random guess). It feels at least conceptually possible to me that MacOS and Windows might use different thread-synchronization behaviors, where perhaps MacOS will always let the chunk-generating-threads do more work next, and Windows is more random and sometimes allows the force\_generate\_chunk\_requests() call to complete before more work has been scheduled in some way, but again, this is just a total guess?

```
# to find the correct PID
ps aux |grep factorio
# then pass that pid in this command
sudo sample 91815 10 -file factorio_sample.txt

# here is the main/interesting thread
    5107 Thread_35281916: GameUpdate
    + 5107 thread_start  (in libsystem_pthread.dylib) + 8  [0x185cef0fc]
    +   5107 _pthread_start  (in libsystem_pthread.dylib) + 136  [0x185cf42e4]
    +     5107 std::__thread_proxy[abi:v160006]<std::tuple<std::unique_ptr<std::__thread_struct>, void (WorkerThread::*)(), WorkerThread*>>(void*)  (in factorio) + 72  [0x1029898d0]  thread:293
    +       5107 WorkerThread::loop()  (in factorio) + 172  [0x1020fa99c]  WorkerThread.cpp:70
    +         5107 MainLoop::gameUpdateLoop(MainLoop::HeavyMode)  (in factorio) + 784  [0x1009f8b18]  MainLoop.cpp:1211
    +           5107 MainLoop::gameUpdateStep(MultiplayerManagerBase*, Scenario*, AppManager*, MainLoop::HeavyMode)  (in factorio) + 2580  [0x1009fd304]  MainLoop.cpp:1416
    +             5107 Scenario::update()  (in factorio) + 392  [0x101cd5b10]  Scenario.cpp:1213
    +               5107 LuaContext::update()  (in factorio) + 88  [0x101cd6800]  LuaContext.cpp:180
    +                 5107 LuaEventDispatcher::dispatch(MapTick)  (in factorio) + 900  [0x101d15ac8]  LuaEventDispatcher.cpp:155
    +                   5107 LuaGameScript::runNthTickHandler(MapTick)  (in factorio) + 312  [0x101d84654]  LuaGameScript.cpp:720
    +                     5107 lua_pcallk  (in factorio) + 332  [0x102b82050]  lapi.c:1094
    +                       5107 luaD_pcall(lua_State*, void (*)(lua_State*, void*), void*, long, long)  (in factorio) + 56  [0x102b8c40c]  ldo.c:625
    +                         5107 luaD_rawrunprotected(lua_State*, void (*)(lua_State*, void*), void*)  (in factorio) + 60  [0x102b8b688]  ldo.c:137
    +                           5107 luaD_call(lua_State*, lua_TValue*, int, int)  (in factorio) + 156  [0x102b8b8d8]  ldo.c:426
    +                             5107 luaV_execute(lua_State*)  (in factorio) + 2496  [0x102b6f0d4]  lvm.c:717
    +                               5107 luaD_precall(lua_State*, lua_TValue*, int)  (in factorio) + 620  [0x102b8be9c]  ldo.c:350
    +                                 5107 LuaBinder<LuaSurface>::callWrapperOnObject(lua_State*, LuaSurface*, int)  (in factorio) + 80  [0x1028950f0]  LuaBinder.hpp:281
    +                                   5107 LuaSurface::luaForceGenerateChunkRequests(lua_State*)  (in factorio) + 20  [0x101e9c424]  LuaSurface.cpp:2066
    +                                     5107 MapGenerationManager::generateAllSynchronously(Surface&)  (in factorio) + 1040  [0x101b68cc0]  MapGenerationManager.cpp:301
    +                                       5107 MapGenerationManager::AsyncHelper::generateAllOfStatus<AsyncEntityTask, (ChunkGeneratedStatus::Enum)50>(std::array<std::deque<MapGenerationRequest>, 4ul> const&, unsigned long, Surface&)  (in factorio) + 1044  [0x101b6b1d4]  MapGenerationManager.cpp:247
    +                                         5105 std::this_thread::sleep_for(std::chrono::duration<long long, std::ratio<1l, 1000000000l>> const&)  (in factorio) + 64  [0x100742250]

# and there were many threads that looked like this:
    5107 Thread_35317293
    + 5107 thread_start  (in libsystem_pthread.dylib) + 8  [0x185cef0fc]
    +   5107 _pthread_start  (in libsystem_pthread.dylib) + 136  [0x185cf42e4]
    +     5107 std::__thread_proxy[abi:v160006]<std::tuple<std::unique_ptr<std::__thread_struct>, void (std::__async_assoc_state<void, std::__async_func<AsyncEntityTask::AsyncEntityTask(ChunkPosition const&, Surface&, std::atomic<unsigned long>&)::'lambda'()>>::*)(), std::__async_assoc_state<void, std::__async_func<AsyncEntityTask::AsyncEntityTask(ChunkPosition const&, Surface&, std::atomic<unsigned long>&)::'lambda'()>>*>>(void*)  (in factorio) + 72  [0x1027ceacc]  thread:293
    +       5107 std::__async_assoc_state<void, std::__async_func<AsyncEntityTask::AsyncEntityTask(ChunkPosition const&, Surface&, std::atomic<unsigned long>&)::'lambda'()>>::__execute()  (in factorio) + 32  [0x1027cea00]  future:1008
    +         5107 EntityMapGenerationTask::computeInternal()  (in factorio) + 104  [0x101b43c70]  EntityMapGenerationTask.cpp:134
    +           5104 Noise::multioctaveNoise(float, float, unsigned int, unsigned int, float, float, float, float, float, NoiseScratch&, float*) const  (in factorio) + 332  [0x101c59e84]  Noise.cpp:419
    +           ! 2093 Noise::noise(float, float, unsigned int, unsigned int, float, float, float, NoiseScratch&, float*) const  (in factorio) + 900,904,...  [0x101c597bc,0x101c597c0,...]  Noise.cpp:197
    +           ! 1242 Noise::noise(float, float, unsigned int, unsigned int, float, float, float, NoiseScratch&, float*) const  (in factorio) + 864,836,...  [0x101c59798,0x101c5977c,...]  Noise.cpp:236
```

---
**clifffrey:** FWIW, I spent a bit longer looking at this, and sometimes (most of the time even), there is actually no lua running when it gets stuck. However, there is the one thread hard at work doing map generation/noise things. So, it is even less clear to me what might be going on. Perhaps alien biomes or something else that changes mapgen is somehow responsible? But, just a guess.

In any case, I also filed an official bug report to try and get more advice about how to move forward: <https://forums.factorio.com/viewtopic.php?t=128358>

---
**Genhis:** Your mod sets MultioctaveNoise::octaves to infinity in the save file attached by clifffrey. The fix (when merged) is to crash the game to main menu on all systems if it happens. I recommend debugging map gen settings and trying to figure out why it happens - most likely it's a division by zero.

---
**MFerrari (mod author):** > Your mod sets MultioctaveNoise::octaves to infinity in the save file attached by clifffrey. The fix (when merged) is to crash the game to main menu on all systems if it happens. I recommend debugging map gen settings and trying to figure out why it happens - most likely it's a division by zero.

Thank you @Genhis and @clifffrey... the new version is rising the error, but I'm debugging and not finding the cause of the issue... its a map\_gen\_setting..
I have no idea what MultioctaveNoise::octaves are... =(
