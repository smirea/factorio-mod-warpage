# Wrong Pipe Contents

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/681903ca5a2c3fac2e6dc410
- Thread ID: 681903ca5a2c3fac2e6dc410
- Started by: Ranec2

---
**Ranec2 (op):** I have two possibly related bugs. I do not have clear reproduction steps yet but the issues have happened a few times without me touching anything. I assume it is either during platform upgrade or warping at time.

1. Restricted Recipes - It seems that recipes that require a particular planet may be unset. This has happened for eggs, science packs and bacteria growing so far. I happen to run across the buildings and there is no recipe set.
2. I have had the wrong fluid in pipes after some period of time. It seems to happen most with Electrolyte leaking back into the heavy oil for no particular reason. I am not around and all of sudden came back to it being stuck again and having to clear the pipe. A similar thing happened with heavy to light oil cracking.

I will track warps and upgrade for a bit to see if I can get a clear picture but wanted to mention it to see if anyone else has noticed this.

---
**Venca123 (mod author):** 1. Yes this is known bug (mostly happens when you load game on a planet that is not nauvis) - Sadly the best solution would be to always reset recipes that are not valid on a planet (after warp) and I think that players would not want that. Doing it the other way around is really hard, because game is trying hard to not allow using recipes on wrong planets
2. Yes on platform teleport wrong liquid can end up in wrong pipe (only if recipes support input/output on same pipe) you can work around this with pumps that are set to specific liquid, but for now I do not know how to solve this.

---
**Ranec2 (op):** 1. It must be more than just loading into the world. I just loaded in on Gleba and everything retained the recipes. This doesn't seem to happen too often so it just wasn't something I was watching for.
2. Placing another pump to push out the wrong fluid was the solution I used. This seems to only happen for my Electrolyte on every warp. I have only seen it one other time but that one building is consistently doing it. Maybe because it has three different fluids?

---
**CrankyHerk:** Any building that takes multiple fluids and can be rotated. I've seen it happen with Cryogenic and Electromagnetic plants for sure. My theory is that when the platform is loaded up they start in one orientation and rotate to the other when finalized but it's long enough to pollute the pipes. I also did the smoothie pipe method of using pumps with filters to empty out unwanted fluids.

---
**phatmaster:** CrankeyHerk, this was exactly my solution. If you hook a filter pump up to the pipe that 100% should never have the fluid, and have it pump into a few extra pipes you can clear out the problem. The key is to either always pump into a EMPTY pipe network, or one that can reliable not be full

---
**phatmaster:** 100% agree, it seems to only happen on buildings with multi-input that are flipped, or connected to a empty network at warp

---
**Venca123 (mod author):** This will be in progress for a while probably. I have a few things in progress that could solve it
