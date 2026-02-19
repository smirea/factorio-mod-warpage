# Crash

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/69910b466bfa5f89a16745fe
- Thread ID: 69910b466bfa5f89a16745fe
- Started by: superman0604

---
**superman0604 (op):** When completing the "Ground Platform upgrade 1" which starts the wave/warp timer. Factorio experimental version 2.0.75

The mod Warptorio 2.0 (Space Age) (0.2.13) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_research\_finished (ID 22)
Unknown tile name: warp\_tile\_world
stack traceback:
[C]: in function 'set\_tiles'
**warptorio-space-age**/control.lua:802: in function 'func'
**warptorio-space-age**/control.lua:1909: in function <**warptorio-space-age**/control.lua:1905>

Love the mod by the way. Warptorio is my favorite overhaul mod, appreciate you (and other modders) for keeping it alive and going.

---
**Venca123 (mod author):** I will take a look, but it will take a bit.

---
**Venca123 (mod author):** I did not have any issue even on experimental. Can you send me the full mod list? Looks like something is editing same tiles like I am

---
**superman0604 (op):** I thought that might be the case. I did disable the propertyrandomizer and was still getting the error. No clue if it was random or related but I switched the ground platform tile type from foundation to concrete and it did complete the research without error. If you still find no problem I'll assume it was the randomizer, it changes just about everything in some way.

0.0.4 - 1stone1brick - 1stone1brick
1.2.0 - Arachnids Enemy - Arachnids\_enemy
1.2.1 - Armoured Biters - ArmouredBiters
1.2.8 - KS Combat Updated - KS\_Combat\_Updated
1.16.4 - Planets Lib - PlanetsLib
2.0.7 - RP Gsystem - RPGsystem
3.3.8 - Rate Calculator - RateCalculator
2.0.4 - Repair Turret - Repair\_Turret
1.0.2 - Science Pack Glow - Science\_pack\_glow
1.0.0 - Sort All Inventories - Sort-All-Inventories
0.3.2 - AAI Containers - aai-containers
0.2.7 - AAI Loaders - aai-loaders
1.3.0 - Acorns Quick Start - acorns-quick-start
2.0.75 - Base - base
1.0.0 - Bot Resistance Modifier - bot-Resistance-Modifier
1.1.6 - Blueprint Manipulation Library - bplib
1.0.0 - Cheaper AAI Loaders - cheaper\_aai\_loaders
0.7.2 - Combat Mechanics Overhaul - combat-mechanics-overhaul
2.0.73 - Elevated Rails - elevated-rails
2.0.2 - Even Distribution - even-distribution
2.0.43 - Factoryplanner - factoryplanner
2.0.2 - Far Reach - far-reach
0.0.4 - Faster Robots - faster-robots
0.16.5 - Factorio Library - flib
0.2.0 - Infinity Invo - infinity-invo
2026.2.12 - Modlist UI - modlist-ui

---

0.4.11 - Propertyrandomizer - propertyrandomizer

---

2.0.73 - Quality - quality
8.0.9 - Scattergun Turret - scattergun\_turret
2.0.73 - Space Age - space-age
0.1.4 - Squeak Through 2 - squeak-through-2
0.2.13 - Warptorio Space Age - warptorio-space-age

---
**Venca123 (mod author):** I have no tested randomizer with the mod, so it might take some time to make it work as expected.
