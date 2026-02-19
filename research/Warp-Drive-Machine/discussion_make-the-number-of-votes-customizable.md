# make the number of votes customizable

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6678a0b0e402654b6517e86d
- Thread ID: 6678a0b0e402654b6517e86d
- Started by: Dial-up

---
**Dial-up (op):** when we play as a group, we usually divide by tasks, so it turns out that some of the players are still on the hook, in this game this means that those who are responsible for the defense cannot start the warp in time, so I want a customizable auto-warp. I wrote a modified condition but did not check it

```
if #votes/cp >= settings.global["warp-percent"].value/100 then
```

---
**MFerrari (mod author):** done
