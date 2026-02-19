# Non-recoverable error when finishing Garden platform upgrade 1

- URL: https://mods.factorio.com/mod/warptorio-space-age/discussion/6880164af21cb380913fd1f2
- Thread ID: 6880164af21cb380913fd1f2
- Started by: Rodrigo129

---
**Rodrigo129 (op):** Game crash when finishing Garden platform upgrade 1

The mod Warptorio 2.0 (Space Age) (0.2.2) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio-space-age::on\_research\_finished (ID 21)
**warptorio-space-age**/map\_gens.lua:92: bad argument #1 of 2 to 'pairs' (table expected, got nil)
stack traceback:
[C]: in function 'pairs'
**warptorio-space-age**/map\_gens.lua:92: in function 'generate'
**warptorio-space-age**/control.lua:421: in function 'new\_random\_surface'
**warptorio-space-age**/control.lua:522: in function 'func'
**warptorio-space-age**/control.lua:1586: in function <**warptorio-space-age**/control.lua:1583>

---
**Venca123 (mod author):** Fixed in 0.2.3
