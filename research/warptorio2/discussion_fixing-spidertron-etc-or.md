# Fixing Spidertron etc or

- URL: https://mods.factorio.com/mod/warptorio2/discussion/66581fecc1c92516378b9cd2
- Thread ID: 66581fecc1c92516378b9cd2
- Started by: PetePablo

---
**PetePablo (op):** Hey, Im trying to get "Spidertron etc." to work with this mod. When the platform warps the data for the spidertron controller is lost. How can I stop this from happening. On your FAQ you talk about a warp blacklist, I guess adding spidertron to this list could fix it or im totally in the wrong ball court. When I type "/remote.call("warptorio2","is\_warp\_blacklisted","modname","entity\_name")" into console nothing come up even when changing the mod name and entity name. It is the console I need to put this in? In the "Warptorio2 Expansion" you get a little robot and I was connecting it up to the warp timer with the ingame logistics circuitry you have and it works great! But sadly stops working when we warp. It lost its signal with the spidertron even though he is on the platform with us. Is this actually possible a other way with another mod? I just want to be able to bring back my spidertrons back to the platform automatically. Any ideas or fixes I could try. All the best, thanks <3

---
**PyroFire (mod author):** The "Spidertron etc." needs to connect to the cloning events and properly update the relevant data and information.
It is not a command you can simply type in the console.

Regarding your expansion related issue, it does seem related to what you're experiencing.
you may be seeing some mod conflicts.
To the best of knowledge, all of this works without any other 3rd party mods.
I suggest uninstalling all 3rd party mods and unofficial extensions and please let us know if this is still an issue for you.

If there is an issue with vanilla warptorio regarding spidertron remotes being disconnected, this is the first report of such an issue.
Could you please confirm if this is the issue for you?
