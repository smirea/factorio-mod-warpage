# Disabling space age errors on warp

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/679f18c470598e20b00c6c4a
- Thread ID: 679f18c470598e20b00c6c4a
- Started by: mikelat

---
**mikelat (op):** This may not be supported, but I attempted to disable space age to simplify the tech tree (I wasn't using any of the space age things). Unfortunately it causes a mod crash on warp - if I shouldn't disable space age mid-playthrough then I completely understand :) save file (it happens a few seconds later): <https://mega.nz/file/mgZySLCC#8v-KZdmlgyBt6Qw0iMZq16y6ahoV1lIDeU-soCUIGR8>

Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
LuaSurface API call when LuaSurface was invalid.
stack traceback:
[C]: in function '**newindex'
\_\_Warp-Drive-Machine**/warp-control.lua:620: in function 'warp\_now'
**Warp-Drive-Machine**/ship-control.lua:602: in function 'update\_ships\_each\_second'
**Warp-Drive-Machine**/control.lua:723: in function <**Warp-Drive-Machine**/control.lua:722>

---
**m0rt1mer:** I have the same issue - I started with Space Age and then realized I don't want to replay entire Space Age after. Disabling Space Age might not work (it is probably going to break everything), but it could be possible to just add an option not to add the space age science packs to the victory technologies? This would basically make the Space Age stuff optional, without maybe breaking everything?
