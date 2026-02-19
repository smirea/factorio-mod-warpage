# [0.2.2]Double-"except" remove bug in item_prices.lua

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/6651367d8bd51143150696cb
- Thread ID: 6651367d8bd51143150696cb
- Started by: Honktown

---
**Honktown (op):** In file "item\_prices.lua" Line 551, there is a bug:

```
    for y=1,#except do
    if string.find(opt[x].name,except[y]) then table.remove(opt,x) end end
    end
```

When there is more than one except, there is a risk of an error. example: except[1] is found, so opt,x is removed. OK.... -> y=2, opt[x] is nil because it has been removed, opt[x].name <-----
Error while running event Warp-Drive-Machine::on\_nth\_tick(30)
**Warp-Drive-Machine**/item\_prices.lua:551: attempt to index field '?' (a nil value)

;\_;

Fix, break after remove. It has been removed, stop checking:
if string.find(opt[x].name,except[y]) then table.remove(opt,x) break end end

---
**MFerrari (mod author):** thanks Honktown.

---
**Honktown (op):** Thank you. Sorry I don't know which mod(s) caused it.
