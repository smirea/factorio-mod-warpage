# Belt Balancer mod does not like to be Warped.

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6430ce9e4a7b4ee05d41c621
- Thread ID: 6430ce9e4a7b4ee05d41c621
- Started by: ShadowKOD

---
**ShadowKOD (op):** IDK if it can be fixed But figured id put the error log here.
all i did was have a belt balancer from the Belt Balancer (Improved Performance) mod on the warp pad and i tried warping and it crashed.

The mod Belt Balancer (Improved Performance) (3.1.3) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event belt-balancer-performance::on\_nth\_tick(8)
LuaTransportLine API call when LuaTransportLine was invalid.
stack traceback:
[C]: in function '**index'
\_\_belt-balancer-performance**/objects/balancer.lua:224: in function 'run'
**belt-balancer-performance**/helper/message-handler.lua:33: in function <**belt-balancer-performance**/helper/message-handler.lua:31>

---
**PyroFire (mod author):** This is an issue with belt balancer probably during cloning or destroying.
