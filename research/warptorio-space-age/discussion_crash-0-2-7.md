# Crash 0.2.7

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/688d246912149c3916feaace
- Thread ID: 688d246912149c3916feaace
- Started by: Nakesha

---
**Nakesha (op):** Game crash with Fulgoran Enemies mod enabled.
Error ModManager.cpp:1758: Error while loading technology prototype "warp-factory-platform-1" (technology): Key "icon" not found in property tree at ROOT.technology.warp-factory-platform-1.icons[0]
Modifications: Warptorio 2.0 (Space Age)

---
**Venca123 (mod author):** Can you please send all other mods that you have installed?

---
**kelpop86:** The mod Warptorio 2.0 (Space Age) (0.2.7) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_gui\_click (ID 1)
LuaSpacePlatform::space\_location is read only.
stack traceback:
[C]: in function '**newindex'
\_\_warptorio-space-age**/control.lua:1284: in function 'next\_warp\_zone\_space'
**warptorio-space-age**/control.lua:1357: in function 'next\_warp\_zone'
**warptorio-space-age**/control.lua:1633: in function <**warptorio-space-age**/control.lua:1594>

Mods:
Elevated Rails
Quality
Space Age
Warptorio 2.0 (Space age)

---
**Venca123 (mod author):** This should not be an issue with factorio 2.0.60. That variable used to be read only. If you want to stay on lower versions please disable "enable flying via space during warp time" in mod settings

---
**Nakesha (op):** So if, this mods enabled it crashes
2.255 Checksum of base: 1534080171
2.255 Checksum of fdsl: 0
2.255 Checksum of boblibrary: 3203393161
2.255 Checksum of elevated-rails: 3379156108
2.255 Checksum of flib: 728527376
2.255 Checksum of quality: 3594706471
2.255 Checksum of bobassembly: 2550691427
2.255 Checksum of space-age: 1185576405
2.255 Checksum of Electric\_flying\_enemies: 2129958061
2.255 Checksum of reskins-library: 2777375998
2.255 Checksum of reskins-bobs: 177176971
2.255 Checksum of warptorio-space-age: 2050612737
2.255 Checksum of reskins-compatibility: 1470512085
