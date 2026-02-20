# Design Guidelines

1. Planets are temporary and should be treated as such - mechanics should cause permanent destructive actions
2. Lean in heavily on the warp theme - to a ridiculous extent
3. Fun and fast paced - the game should give you tools to speed up progression, despite new challenges, there should never be a slog in progression and it should never be tedious
4. Restriction breeds creativity: no chests, no logistic system, no conventional weapons (gun, flame)
5. Challenging, but fair - I want this to be hard but explicitly no bullshit: no infinite waves that walk on water and spawn stompers when you're on green science, no forcing you into positions where you must lose progress to survive, yes to predictable increase in difficulty
6. Single-player focus - optimized for solo, support multiplayer
7. Promote less used mechanics: combat bots, mines, consumables, quality
8. Throughput instead of storage - no chests but easy to gather resources, philosophy should be to go to a place and build/research as fast as much as possible
8.1. This means that researches would have to accomodate sparse resources - all techs needing most research packs is a big limitation

# Big Novel Features

## Quality Upgrade

The idea behind this is to make it easier to engage the quality mechanic that normally needs extra space and time - things you have much less of here.
Research that converts all entities to the next quality tier and make such that all buildings will always be at least that quality. also upgrades all existing entities in your inventory.
There is a tier research for various classes: bots, inserters, miners, assemblers, infrastructure, military, personal equipment. Each would be a trigger tech requiring you produce X of quality of each item (e.g. make 5 of each uncommon inserter to trigger uncommon inserter quality). completing 3 of any of the quality techs unlocks all others at that level, disables that combo in the future (i.e. you need a different set of 3)

## Tech Confluence

All early game technologies lead up to a single "A fork in the road" tech that must be researched. Once researched it warps the player to a special zone where they must choose one of 3 paths: Bots, Belts, Boxes. Each path has significant upsides and downsides and will significantly change how they will play the game

- unlocks right before space science
- update the icon of all techs that are affected by your decision to mark how they've been affected (positively or negatively)
- create dummy researched "researches" for the recipes that were blocked off and describe them as the consequences of your choices


| Path of the -->       | Belt    | Box                          | Bot                                                                                                |
| ----------------------- | --------- | ------------------------------ | ---------------------------------------------------------------------------------------------------- |
| belt tier             | turbo   | express                      | no belts                                                                                           |
| belt stack            | 4       | 2                            | 0                                                                                                  |
| stack inserters       | yes     | no                           | no                                                                                                 |
| logistics             | no      | no                           | yes                                                                                                |
| power                 | nuclear | nuclear                      | fusion                                                                                             |
| factory size research | 1x      | 2x                           | 4x                                                                                                 |
| **other upsides**     |         | linked chests in each region | 30min one time grace period to rebuild; grants 50 red and blue chests; new research 2by2 requester |
| **other downsides**   | no legendary quality        |                              | removes all bets                                                                                   |

## Containerization and Modularity

I don't like that in these mods platforms are squares and that they grow from the center outwards, meaning they are ugly and every expansion level needs a full redesign of the base

In Warp Age, factory size technologies unlock new factory modules, that get connected to your base like rooms with narrow doorways. Modules have odd shapes and you can move modules around, potentially even save modules to deploy them on a per-need basis

The idea of this is to allow swapping out modules, say you need more defence on the left side, swap out research with a weapons module

# Other Features
- redesign break: get a guaranteed chill warp where the timer is tripled to allow you to rebuild the base in peace. Balance it with increasing the difficulty after the break
