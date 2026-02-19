# Improvements to mod API

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6965a69a96eced5fb4428032
- Thread ID: 6965a69a96eced5fb4428032
- Started by: bountygiver

---
**bountygiver (op):** There's a lack of remote interface to access the ship data, such ship data is only communicated during the custom warp events, so other mods can only access them during warping and have to cache those data and rely on potentially outdated data.

Additional custom event for right before a planet is generated, currently if a mod want to modify the characteristics of a planet, the only opportunity is to hook to the "on\_ship\_warping" event and force the surface to destroy all chunks and regenerate with the new mapgen settings, this works but it can cause desyncs with the storage.planets data the mod is storing, adding a new custom event right before finalizing the mapgen settings in the storage can allow more customization of planet generation

Less hardcodes, there's a few resources behaviour are completely hard coded, it will be nice if those behaviour can be customized from a mod-data prototype instead, especially when we want to add scrap/calcite to the planets generation without relying on having to go to those space age planets, they will not show up on the search for rich resources menu, and if any autoplace controls of other resources are added after those 2 resources, it will cause the indexing to desync and searching for those items will cause you to search for a resource 2 index behind instead (this can also leading you to search for scrap/calcite if you select the first 2 resources after them)
