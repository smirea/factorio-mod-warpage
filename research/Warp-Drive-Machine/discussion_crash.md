# Crash

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6746b38338a7ad7690a1937f
- Thread ID: 6746b38338a7ad7690a1937f
- Started by: JGAO

---
**JGAO (op):** Engine-level crash. When the ship warpped to space, I alt-clicked the "Empty Space" tile and then clicked the "Planet Orbit" under "Appears On" on the right side of the Factoriopedia.

---

10560.049 Info AppManager.cpp:310: Saving to \_autosave2 (blocking).
10560.326 Info AppManagerStates.cpp:2095: Saving finished
10860.363 Info AppManager.cpp:310: Saving to \_autosave3 (blocking).
10860.590 Info AppManagerStates.cpp:2095: Saving finished
10932.315 Time travel logging:
4358.200 Deleted 798 chunks.
8818.089 Deleting surface planet\_1\_player index 6.
10920.596 Deleting surface planet\_2\_player index 8.
10932.315 Error CrashHandler.cpp:641: Received SIGSEGV
Factorio crashed. Generating symbolized stacktrace, please wait ...
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\StackWalker\StackWalker.cpp(924): StackWalker::ShowCallstack
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Util\Logger.cpp(337): Logger::writeStacktrace
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Util\Logger.cpp(379): Logger::logStacktrace
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Util\CrashHandler.cpp(183): CrashHandler::writeStackTrace
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Util\CrashHandler.cpp(654): CrashHandler::SignalHandler
minkernel\crts\ucrt\src\appcrt\misc\exception\_filter.cpp(219): \_seh\_filter\_exe
D:\a\_work\1\s\src\vctools\crt\vcstartup\src\startup\exe\_common.inl(304): `__scrt_common_main_seh'::`1'::filt$0
D:\a\_work\1\s\src\vctools\crt\vcruntime\src\eh\riscchandler.cpp(389): \_\_C\_specific\_handler
ERROR: SymGetLineFromAddr64, GetLastError: 487 (Address: 00007FFA274728BF)
00007FFA274728BF (ntdll): (filename not available): \_chkstk
ERROR: SymGetLineFromAddr64, GetLastError: 487 (Address: 00007FFA27422554)
00007FFA27422554 (ntdll): (filename not available): RtlRaiseException
ERROR: SymGetLineFromAddr64, GetLastError: 487 (Address: 00007FFA274713CE)
00007FFA274713CE (ntdll): (filename not available): KiUserExceptionDispatcher
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Space\PlanetPrototype.cpp(341): PlanetPrototype::generates
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Gui\Factoriopedia.cpp(935): Factoriopedia::generateContains
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Gui\Factoriopedia.cpp(470): Factoriopedia::updateSpaceLocation
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Gui\Factoriopedia.cpp(160): Factoriopedia::update
C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30133\include\functional(823): std::\_Func\_impl\_no\_alloc<`Factoriopedia::button<ID<SpaceLocationPrototype,unsigned short> >'::`2'::<lambda\_1>,void>::\_Do\_call
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\Agui\Widget\Widget.cpp(1669): agui::Widget::dispatchClick
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\Agui\Widget\Widget.cpp(1651): agui::Widget::dispatchMouseDown
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\Agui\Gui.cpp(268): agui::Gui::handleMouseDown
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\Agui\Gui.cpp(981): agui::Gui::dispatchMouseEvents
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\libraries\Agui\Gui.cpp(815): agui::Gui::logic
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\GlobalContext.cpp(1399): GlobalContext::updateGui
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\MainLoop.cpp(1089): MainLoop::processEvent
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\MainLoop.cpp(762): MainLoop::processEvents
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\MainLoop.cpp(604): MainLoop::prePrepare
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\MainLoop.cpp(683): MainLoop::mainLoopStep
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\MainLoop.cpp(412): MainLoop::run
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Main.cpp(1357): fmain
C:\Users\build\AppData\Local\Temp\factorio-build-xUkeqh\src\Main.cpp(1379): wmain
D:\a\_work\1\s\src\vctools\crt\vcstartup\src\startup\exe\_common.inl(288): \_\_scrt\_common\_main\_seh
ERROR: SymGetLineFromAddr64, GetLastError: 487 (Address: 00007FFA25FE7374)
00007FFA25FE7374 (KERNEL32): (filename not available): BaseThreadInitThunk
ERROR: SymGetLineFromAddr64, GetLastError: 487 (Address: 00007FFA2741CC91)
00007FFA2741CC91 (ntdll): (filename not available): RtlUserThreadStart
Stack trace logging done
10941.614 Error CrashHandler.cpp:190: Map tick at moment of crash: 274300
10941.764 Info CrashHandler.cpp:318: Executable CRC: 256833610
10941.764 Error Util.cpp:95: Unexpected error occurred. If you're running the latest version of the game you can help us solve the problem by posting the contents of the log file on the Factorio forums.
Please also include the save file(s), any mods you may be using, and any steps you know of to reproduce the crash.
10947.173 Uploading log file
10947.314 Error CrashHandler.cpp:270: Heap validation: success.
10947.315 Creating crash dump.
10947.629 CrashDump success
