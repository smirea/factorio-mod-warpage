# Picker Dollies

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/66ac27b30a9df0441ba200d5
- Thread ID: 66ac27b30a9df0441ba200d5
- Started by: DemonicLaxatives

---
**DemonicLaxatives (op):** I would love support for Picker Dollies mod. <https://mods.factorio.com/mod/PickerDollies>
Personally, I've grown very accustomed to it. And it seems even more useful in the confined space of the ship where I have chests full of stuff I'd rather not pass though my inventory or mess with transferring liquids between tanks to move them.
The mod author has provided API, so at the very least turrets and the ship control entities could be easily blacklisted, I would hate to accidentally brick my ship by accidentally nudging the console.
IDK if checking for if an entity is moved to a valid tile would be easy, and it could be left up to the player abide by the rules, but that level of support would be as much as one could wish for.

---
**MFerrari (mod author):** Ohh thats a danger mod to use here. So many possibilities to break things... I dont know the mod.. does it clone entities ?

---
**DemonicLaxatives (op):** Upon quick inspection, the mod appears to use `entity.teleport`
