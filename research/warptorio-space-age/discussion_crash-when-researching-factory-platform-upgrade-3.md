# Crash when researching Factory platform upgrade 3

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/69613671c77dd9d27ac3ed03
- Thread ID: 69613671c77dd9d27ac3ed03
- Started by: Jumpforce

---
**Jumpforce (op):** The error in question:

The mod Warptorio 2.0 (Space Age) (0.2.12) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_research\_finished (ID 22)
**warptorio-space-age**/control.lua:80: attempt to perform arithmetic on global 'r\_sqrt3\_half' (a nil value)
stack traceback:
**warptorio-space-age**/control.lua:80: in function 'generate\_ellipse'
**warptorio-space-age**/control.lua:490: in function 'func'
**warptorio-space-age**/control.lua:1945: in function <**warptorio-space-age**/control.lua:1941>

Mods:
base 2.0.72
elevated-rails 2.0.30
quality 2.0.72
space-age 2.0.72
alien-biomes 0.7.4
alien-biomes-graphics 0.7.1
Bottleneck 0.12.1
CharacterModHelper 2.0.4
even-distribution 2.0.2
far-reach 2.0.2
flib 0.16.5
MechanicusMiniMAX 0.1.8
Pi-C\_lib 2.0.4
RateCalculator 3.3.7
VehicleSnap 2.0.3
warptorio-space-age 0.2.12

The game crashes when the science finishes and the platform should expand.
If you need any more info just hit me up.
