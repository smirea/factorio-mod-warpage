# 报错

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68a4703fcf68546359165e2e
- Thread ID: 68a4703fcf68546359165e2e
- Started by: xunli001

---
**xunli001 (op):** Error while running event Warp-Drive-Machine::on\_gui\_opened (ID 99) Too many parameters for localised string: 22 > 20 (limit). stack traceback: [C]: in function'**newindex' 'update\_ship\_terminal\_gui' Warp-Drive-Machine**/gui-control.lua:845: in function 'ship\_terminal\_gui\_opened" Warp-Drive-Machine\_\_/gui-control.lua:1336: in function Warp-Drive-Machine\_\_/gui-control.lua:750: in function Warp-Drive-Machine\_\_/gui-control.lua:742>

---
**MFerrari (mod author):** fixing

---
**xunli001 (op):** 模组「曲速飞船（1.0.8）」引发了无法恢复的错误。请向模组作者反馈此错误。 Error while running event Warp-Drive-Machine::on\_nth\_tick(60) Too many parameters for localised string: 22 > 20 (limit). stack traceback: [C]: in function'**newindex' Warp-Drive-Machine**/gui-control.lua:843: in function 'update\_ship\_terminal\_gui' Warp-Drive-Machine\_\_/gui-control.lua:379: in function 'update\_all\_guis' Warp-Drive-Machine\_\_/control.lua:767: in function Warp-Drive-Machine\_\_/control.lua:762>

[科技：返回之前的已知星球]研究完成。 ！注意！太空飞船扫描仪检测到一个飞船遗物的存在： Ancepetos pacifa(#16)星球上的 [物品：量子通量核心] 您飞船的曲速飞船需要修理。请在终端上检查。
问题并没有解决，出现问题的地方是在完成这个科技以后，报错和这条信息同时出现的

---
**MFerrari (mod author):** Can I have your saved game ?

---
**xunli001 (op):** 我不知道该怎么把游戏上传给你，我尝试删除了所有的模组和物品，但是依然报错。
