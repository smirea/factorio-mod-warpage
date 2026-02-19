# Turrets "disabled by script"

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68dc293f31ff4ff878e6cfb7
- Thread ID: 68dc293f31ff4ff878e6cfb7
- Started by: Turmfalke

---
**Turmfalke (op):** hello,
I'm encountering a bug where sometimes turrets enter a permanent "disabled by script" state. Pretty annoying if you get overrun due that. Can't really reproduce it at the moment.

Maybe related to the platform warping while the turret is booting up?

---
**Ranec2:** I think what you are experiencing is expected. There are three ways that I know of to end up there.

1. After warping there is just a few seconds they are not active.
2. When placing down turrets it takes around 10 seconds to activate. This stops current creeping nests.
3. There are warp events that disable some percent of your defenses. This seems to be on the order of a few minutes.
