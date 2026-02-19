# how do warp abilities work?

- URL: https://mods.factorio.com/mod/warptorio2/discussion/63cd9d6772c086cd2e23685f
- Thread ID: 63cd9d6772c086cd2e23685f
- Started by: anyoneeb

---
**anyoneeb (op):** I've researched the three warp abilities: stabilize, accelerate, and chart. The chart ability seems pretty straightforward. The other two don't appear to do anything. And the research descriptions reference a "cooldown", but instead the abilities appear to be controlled by an energy bar that I don't understand. I assume that is drawing an increasing amount of energy from my base the longer the ability is active?

Looking at the source code, it looks like
\* stabilize reduces the *increase* in pollution by a factor of 20 (from the text description I expected it to reduce pollution/evolution): <https://github.com/PyroFire232/warptorio2/blob/5d875fa4ddf9f8280678409d7ff3412b000159fc/control_main_helpers.lua#L277> . So to be most useful, would probably want to use this early on after warping to delay the biter attacks by a few minutes.
\* accelerate doesn't appear to do anything at all, but maybe I'm looking in the wrong place: <https://github.com/PyroFire232/warptorio2/search?q=accelerating&type=>
