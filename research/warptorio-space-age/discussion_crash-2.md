# Crash

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/692779f93da52e850627a936
- Thread ID: 692779f93da52e850627a936
- Started by: bloodsparrow

---
**bloodsparrow (op):** We are playing multiplayer and after some point game always crash with a following message(we are on experimental):
link to a save: <https://drive.google.com/file/d/1rgAfrmSzxOhs3FRH_U8VDGlRxrI3hDUW/view?usp=drive_link>

The mod Warptorio 2.0 (Space Age) (0.2.11) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_script\_trigger\_effect (ID 173)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function 'index'
warptorio-space-age/control.lua:2019: in function <warptorio-space-age\_\_/control.lua:1991>

---
**bloodsparrow (op):** Factorio log: <https://drive.google.com/file/d/1vx_UCiOe0RHPDRIraHaw2JIVFNYR06mO/view?usp=drive_link>

---
**Krizs:** I'm the one hosting this save for OP.

We started this playthrough about a week ago at the most, so Factorio version was the same as it is now. I switched back to stable Factorio branch on Steam to see if it helps the crash but the experimental branch is on the same version (2.0.72) so no change was observed, still crashes soon after loading.

Also tried loading the save in single player to see if the crash is multiplayer related, it is not, the crash comes roughly 30 seconds after loading the save.

---
**Venca123 (mod author):** Thank you for the report I will try to fix it asap

---
**Venca123 (mod author):** This should be fixed now

---
**Krizs:** Tested it with the new mod version 2.12 and it seems to work perfectly for now. Thanks for the quick fix!
