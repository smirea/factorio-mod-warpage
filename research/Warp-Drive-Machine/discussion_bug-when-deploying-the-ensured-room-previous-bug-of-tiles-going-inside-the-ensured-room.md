# Bug when deploying the ensured room + previous bug of tiles going inside the ensured room

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/679cf7b2d019f9f669aedc9c
- Thread ID: 679cf7b2d019f9f669aedc9c
- Started by: jnf27170

---
**jnf27170 (op):** Hi MFerrari,

I got a bug when deploying the "rounded ensured room".

Here is my save + a screenshot of the rounded ensured room that is already containing a bug with 3 tiles (on the border of the circle).
<https://drive.google.com/drive/folders/1pwH8dZijt3Rm2hTkSNT6w6NlhYSF8DRj?usp=sharing>
To test it, you just have to deploy the rounded ensured room and you got the bug.
I tried to remove the 3 tiles in editor mode, but the bug persists and I don't know what to do to be able to use this rounded ensured room.
I got these 3 tiles a long time ago. But I think that I just upgraded the diameter of the circle and now the circle is touching the 3 tiles and now, I have this bug.

Here is the bug message :
Le mod Warp Drive Machine (0.9.23) a engendré une erreur non récupérable.
Merci d'informer l'auteur de cette erreur.

Error while running event Warp-Drive-Machine::on\_robot\_built\_entity (ID 15)
Le mod Warp Drive Machine (0.9.23) a engendré une erreur non récupérable.
Merci d'informer l'auteur de cette erreur.

Error while running event Warp-Drive-Machine::on\_entity\_cloned (ID 133)
LuaEntity API call when LuaEntity was invalid.
stack traceback:
[C]: in function '**index'
\_\_Warp-Drive-Machine**/warp-control.lua:1393: in function <**Warp-Drive-Machine**/warp-control.lua:1314>
stack traceback:
[C]: in function 'clone\_brush'
**Warp-Drive-Machine**/warp-control.lua:1161: in function 'check\_build\_insured\_room'
**Warp-Drive-Machine**/control.lua:1590: in function <**Warp-Drive-Machine**/control.lua:1542>

Very great mode by the way !!

---
**jnf27170 (op):** I removed the sucker from the rounded ensured room and now it s working !
