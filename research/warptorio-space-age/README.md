# warptorio-space-age

- Mod URL: [https://mods.factorio.com/mod/warptorio-space-age](https://mods.factorio.com/mod/warptorio-space-age)
- Owner: Venca123
- Downloads: 9113
- Category: Overhaul
- Summary: Build your base on a platform that warps from planet to planet and escape biters before they overwhelm you.

## Demo Images

| Image 1                                                                                                                                                                                           | Image 2                                                                                                                                                                                           | Image 3                                                                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![demo-1](https://assets-mod.factorio.com/assets/ceaacb21a646fe85b1ff1350bad8f2f96b88a909.thumb.png)](https://assets-mod.factorio.com/assets/ceaacb21a646fe85b1ff1350bad8f2f96b88a909.thumb.png) | [![demo-2](https://assets-mod.factorio.com/assets/3e58341e7dfd8c95f9e37adc88356a501ca83774.thumb.png)](https://assets-mod.factorio.com/assets/3e58341e7dfd8c95f9e37adc88356a501ca83774.thumb.png) | [![demo-3](https://assets-mod.factorio.com/assets/faebdf7cb9a5b6966eec1f1b613e70160a0cdebe.thumb.png)](https://assets-mod.factorio.com/assets/faebdf7cb9a5b6966eec1f1b613e70160a0cdebe.thumb.png) |

## Mod Info

- Owner: [Venca123](https://mods.factorio.com/user/venca123)
- Source: [https://github.com/VencaCZ/warptorio-...](https://github.com/VencaCZ/warptorio-space-age)
- Homepage: <https://openfun.itch.io>
- License: [GNU GPLv3](https://opensource.org/licenses/gpl-3.0)
- Created: 1 year, 1 day ago
- Latest Version: 0.2.13 (23 days ago)
- Factorio version: 2.0
- Downloaded by: 9.11K users

## Main Page Content

## Warptorio (Space Age)

Hi, I liked the original concept of this mod but no-one made it work in 2.0 so I just did it myself.  
Enjoy.

## New Features

- Balanced and added a bunch of vanilla researches but less that warptorio 2 (they are no longer needed with quality research).
- Fixed a bunch of essential bugs: Original warptorio did not play well with new QOL so it was redesigned to account for that
- Added support for all planets + their research. If you want more planets feel free to add them in a same way like you would to normal space exploration.
- Overhaul: Floors were completely changed to account for gameplay centered around various planets. Now your main floor will be ground (so you can research planet specific things)
- Overhaul: Science has been completely reworked now with special end game research that will fully test your platform
- Overhaul: Re-worked how power delivery works to make it easier in early game
- Overhaul: Re-worked enemies to make them possible on all planets. Feel free to add other enemy mods, if it is too easy
- New Feature: Warptorio does not start untill you research green science or warp platform, to let you stockup on resources

## Special thanks

- Nonoce for originally creating this fantastic mod - <https://mods.factorio.com/mod/warptorio>
- PyroFire for expanding on the original mod - <https://mods.factorio.com/mod/warptorio2>
- Jimmyster for the text translation
- PreLeyZero For creating assets for Exotic industries that I could use to make things look better

## Discord

Since people wanted discord to talk about this (and some even found my personal server) I am putting it here as well (It now has channel for warptorio)  
[Discord Link Here](https://discord.gg/rUcDrB84y8)

## Interfaces

Starting with 0.2.8 there is now interface to add better support for more planet variants

Here is short tutorial how to do it.

1. Install mods that you want this variant to be based on
2. Select new single player game and using the sliders for generating new planet create the variant that you want (make sure to check all planets if you are making variant for more that one)
3. Start a new game and go to edit mode (/editor)
4. Generate all surfaces (Surfaces -> Generate planets)
5. Run this command `/c for k,v in pairs(game.surfaces) do helpers.write_file(k.."_{your_variant_name}.json",helpers.table_to_json(game.surfaces[k].map_gen_settings)) end`
6. locate new variants in .factorio/script-output and transform them from json back to lua
7. Make a mod that depends on warptorio
8. In your mod add your variants using this remote interface `remote.call("warptorio", "edit_planet_variants", variant,planet,map_gen_settings)`

## Hall of fame

Complete runs from youtube (If you finished run as well, please let me know, so I can add you to this hall of fame). These should be ordered based on when they were played (Oldest one first)

[ラスコーリニコフ **Japanese**](https://www.youtube.com/watch?v=GOjzMlwYUSw&list=PLblPwPAyrytjkWXMAbRMnU8pkf4HP4uPK) - As far as I know this is the first time someone finished this mod.  
[Pettan **English** 1st run](https://www.youtube.com/watch?v=l3_ZGQYay7I&list=PLLbp7fe0RMzvBMStSZUobamHSBocj8vVb&pp=0gcJCbAEOCosWNin)  
[JohnMegacycle **English**](https://www.youtube.com/watch?v=UB9UMmoqEB8&list=PLYhuQUmCiA-CCf7KEK47ofUq3qee3LPht)  
[Pettan **English** 2nd run](https://www.youtube.com/watch?v=ndCnOsOazMI&list=PLLbp7fe0RMzucV0ctakqB5JhuzFLKOfxZ&pp=0gcJCbAEOCosWNin)  
[Pettan **English** 3nd run](https://www.youtube.com/watch?v=jjjeLazlgdE&list=PLLbp7fe0RMzvTFH7ss4zfYV9R15jOHeJ3)  
[Eggsceptional **English**](https://www.youtube.com/watch?v=MPK-nKyrwgk)
