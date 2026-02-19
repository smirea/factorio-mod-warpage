# Crash when spawning bosses [Done]

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/68017031f665c7ebe7ca418e
- Thread ID: 68017031f665c7ebe7ca418e
- Started by: Lowman555

---
**Lowman555 (op):** Game will occasionally error out, happened before with explosive biter instead of frost.

The mod Warptorio 2.0 (Space Age) (0.0.17) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_tick (ID 0)
Unknown entity name: maf-boss-frost-spiter-2
stack traceback:
[C]: in function 'find\_non\_colliding\_position'
**warptorio-space-age**/control.lua:605: in function 'create\_angry\_biters'
**warptorio-space-age**/control.lua:824: in function 'check\_wave'
**warptorio-space-age**/control.lua:1072: in function <**warptorio-space-age**/control.lua:1031>

---
**Venca123 (mod author):** Can you please send list of mods that you have installed? This is caused when biters cant find spawn position.

---
**Lowman555 (op):** <https://imgur.com/a/31XI3zG>
First image is the general mods, second is the biter mods that I got from the optional dependencies, have them currently removed to prevent the crash.

---
**Venca123 (mod author):** Does this always happen on aquilo?

---
**Lowman555 (op):** It never happens on Aquilo, of the three times it have happened it always happens on Nauvis, though I have not spent much time on planets other than it and Fulgora. (it happened again after I accidentally left the biter mods on to take that screenshot, whoops).

---
**phatmaster:** This happens to me too. Happens on planets like Gleba, nauvic and vulcanus.
<https://www.dropbox.com/scl/fi/r4v1fabd6buanhgw360rz/error.png?rlkey=f9qd6kkq17l7dgspaxjotbj1x&dl=0>

Mods: only recommended

---
**Venca123 (mod author):** This will be fixed over the weekend

---
**Venca123 (mod author):** This is now fixed
