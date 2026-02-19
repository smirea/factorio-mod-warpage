# Any way to use only research without warp mechanic?

- URL: https://mods.factorio.com/mod/warptorio2/discussion/65001bade94f36b1cc15362b
- Thread ID: 65001bade94f36b1cc15362b
- Started by: AndyScull

---
**AndyScull (op):** Hello, I've been playing Warptorio2 for several weeks now and pretty much like how it works.
But recently I've found a fun scenario to play and wondered - can I in some way use Warptorio's techs in it, without activating any other mechanics?
I see I can just deactivate everything in mod settings, but the problem is initial world reset which adds the platform, the scenario I use does the same and Warptorio overwrites the scenario world even if I add it after game start.
I never tried any modding for Factorio , guess I can clone the mod and tinker with scripts, but maybe anyone tried doing the same before?
I know there are others pure research mods out there, I just like Warptorio techs - useful, kinda balanced and in one package

///edit: Finally found some way to remove surface reset conflict, the scenario I am playing had a 'reset' function in which I commented out surface reset, so it added it's functions (market building) to current warptorio world.
But I really thing the whole research tree deserves a spinoff mod, I like it so much

---
**PyroFire (mod author):** To my knowledge, it should be possible to configure warptorio in such a way that you can make effective use of the platform stairs and the techs/upgrades without being subject to warping and whatnot.

Please keep in mind, Warptorio is not designed to be added to an existing save or scenario in any way, shape, or form, instead it is only intended that Warptorio is used when starting a new save, only, with the only exception that the save started with warptorio in the first place.
I would suspect that's why you had surface conflicts.

I welcome you to tinker with the scripts, however I ask that if you choose to distribute your changes that you clearly describe your changes and the fact that there is no warranty offered with regard to the situation that anyone's save files can become corrupt and I cannot fix them. If you can offer that guarantee to fix their save files yourself in the event of major catastrophe, by all means, but I cannot offer that guarantee on unknowable changes made by others like yourself.

In short, it is intended you are able to adjust difficulty settings of the base warptorio2 mod to achieve this, if I have missed any particular settings please let me know them.

---
**AndyScull (op):** > To my knowledge, it should be possible to configure warptorio in such a way that you can make effective use of the platform stairs and the techs/upgrades without being subject to warping and whatnot.

Yeah, I think I did disable everything in settings, like autowarp, pollution, waves, etc. I did it a long time ago so I don't remember what exactly was the stopping factor but it didn't work in all cases. (Probably - it didn't work in scenarios which mess with surfaces)
In the end I just unpacked the mod files and tried to cut out everything related to startup configuration, ui, warps etc. Saved it as my own mod and using it without problems in 4-5 games so far
