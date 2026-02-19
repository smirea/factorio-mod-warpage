# Wrong whitelist/blacklist

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5e20c06cc87478000b459989
- Thread ID: 5e20c06cc87478000b459989
- Started by: darkfrei

---
**darkfrei (op):** <https://mods.factorio.com/mod/SmogVisualPollution/discussion/5e209940c87478000ddba1e7>

---
**Honktown:** Not sure why you linked my discussion here, it's Smog Visual Pollution that has the bug :/

---
**darkfrei (op):** Not the warptorio\_planet\_smog?

---
**Honktown:** No. Smog Visual Pollution has the wrong function names assigned in control.lua (sorry if that wasn't clear). The result is nil is assigned to the remote call. call\_foolist vs call\_foolist\_surface. Easy mistake: the functions are defined call\_foolist(surface)

---
**PyroFire (mod author):** This bug will become obsolete as of warptorio 1.2.6 (unreleased) due to major changes to planets systems.
