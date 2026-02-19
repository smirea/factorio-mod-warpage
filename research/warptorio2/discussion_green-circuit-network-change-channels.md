# Green circuit network change channels

- URL: https://mods.factorio.com/mod/warptorio2/discussion/5f4189553cfa674ff8c27a06
- Thread ID: 5f4189553cfa674ff8c27a06
- Started by: alfa347

---
**alfa347 (op):** Green circuit network change channels if you use them with the stairs. If you connect the green cable to the platformstairs on one level and the go up or down the channelnumber has change one number. So if i get channel 100 on one floor the channel will be 101 and the network doesnt connect to each other.
The red cabels works perfect. Same channel on both floors.

Is this intended or a bug?

---
**PyroFire (mod author):** It's an intentional bug.

My guess is it's related to connecting the circuits between surfaces, which is not exactly intended by the factorio developers e.g. electric poles can't connect between surfaces, hence the weird accumulator transfer thing in the place of such a function. It's fortunate that circuits can be connected without special handling.
