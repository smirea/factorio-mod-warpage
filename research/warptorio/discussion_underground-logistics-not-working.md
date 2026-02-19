# Underground logistics not working

- URL: https://mods.factorio.com/mod/warptorio/discussion/5ce5d64aeaf520000b30071e
- Thread ID: 5ce5d64aeaf520000b30071e
- Started by: Ferlonas

---
**Ferlonas (op):** After upgrading to warp logistics 2, the chest connections between surface and underground level 1 have stopped working. Pipe connections keep working, assuming they're meant to be unidirectional. Underground level 1 to level 2 works fine as well.

Edit: Not sure if surface to underground worked at level 1. I think I only tested how it works with level 1 to 2.

---
**NONOCE (mod author):** I will look if I can reproduce that.

---
**NONOCE (mod author):** Ok I could find and fix this bug, this problem should not occur anymore in 0.2.1. Thank you for posting it.

---
**KryptonRazer:** The right side of the underground logistic still does not work. For belts also as for pipes.

---
**PyroFire:** > The right side of the underground logistic still does not work. For belts also as for pipes.

Incorrect.
In warptorio's current state, one side of the logistics transfers up, the other side transfers down.

---
**KryptonRazer:** OKay, but why can you change there directions of the loaders?

---
**PyroFire:** I'm not sure what you're looking to achieve by asking why, but the answer is: Because that is default factorio behaviour. Why WOULDN'T you be able to change the directions of the loaders?

---
**KryptonRazer:** I don't get it, if it is only for pushing resources upwards, that the direction change does not make any sense?

---
**PyroFire:** I agree it is confusing, and same with the logistics pipes. It took me a while to figure out that each side is separately up/down, and this isn't really indicated anywhere.

It is intuitive to assume the loaders direction dictates how the resources are moved around, but any deviation from default factorio behavior needs to be managed by code.
And right now, that code doesn't exist.
That's why you're getting confused, and i'm sure many other people are too.

I made a discord for warptorio if you want to talk a bit more easily.
<https://discord.gg/a9CNarA>

---
**KryptonRazer:** Okay thanks.

---
**PyroFire:** Directional loaders has been added to the new update: <https://gyazo.com/5332418acf7cfe97d1bd6f279121e488>

I also made the pipes unidirectional while i was at it.
