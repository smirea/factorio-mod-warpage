# Stairs chests wires and cap deleted on mods change.

- URL: https://mods.factorio.com/mod/warptorio2/discussion/61010ab83d7f311567380e17
- Thread ID: 61010ab83d7f311567380e17
- Started by: ccsla

---
**ccsla (op):** I have a weird issue where adding or removing a mod from my current install make it delete the wires (red and green) and the slot cap (and maybe others settings; didn't test) of the stairs chests when loading a warptorio2 savefile.

So adding or removing any mod makes it delete stairs chests wires/settings every time on load.

---
**PyroFire (mod author):** This likely depends on the mods involved.

---
**ccsla (op):** Hi PyroFire! Thanks for your support!

So, I was able to reproduce the bug with only Warptorio2 1.3.5 and its dependency Planetorio 0.1.3 installed.
Adding *any* mod to [this save](https://www.dropbox.com/s/t46fyg0p46k9io5/Warptorio2Test.zip?dl=0) reset the cap of the chests and delete their wires on the top floor.
It looks to me that has something to do with on\_configuration\_changed or migrations as you call it.

Hope it helps (somehow)!

---
**ccsla (op):** -

---
**PyroFire (mod author):** This is still on the todo list.
There are other similar issues related to wires on the chests and around the teleporters.

---
**ccsla (op):** I completely forgot about this 'mod is flawless' list! :D
I didn't think you were keeping it updated, but that's nice you did! I'll check that next time I find something. #ThumbsUp
