# [patch] improve teleporter chest handling

- URL: https://mods.factorio.com/mod/warptorio2/discussion/66676b105553fe43a3b1e4be
- Thread ID: 66676b105553fe43a3b1e4be
- Started by: PoppuTheWeak

---
**PoppuTheWeak (op):** Hello.

Here's a patch to improve handling of teleporter chests during upgrade and planet gate placement:

<https://discord.com/channels/599740535703470110/615078789223022619/1250541365700460634>

The following chest properties are saved and restored:
- chest limit - if defined, kept the same value, else chest has no limit (if you set a limit of eg 5 on a wood chest, and the chest is upgraded to steel chest, the limit is kept to 5; if no limit is set, well, none will be set after upgrade)
- chest requests when the chest is a logistic one - this includes whether the chest uses items from buffer chests or not
- wires between chests and the teleporter, and other entities - the mode is kept for request chests (whether to read content or add request items)
- filter for logistic storage chests

When chests are added (bonus with tri loader or secondary loader/chest), properties of existing chests are also preserved

---
**PyroFire (mod author):** Apparent issue: Logistics requests are not kept between teleporter pickup and placement or research.
Chest limits are also not kept.
Wires are also not kept between research upgrades.

Todo.

---
**PoppuTheWeak (op):** Limits and wires are also not kept when the stairs (between floors and surface) are upgraded - a wooden chest with a limit is replaced by an iron chest with no limit, wires between eg stairs and a chest are not keps. The patch applies back the limit when the chests are upgraded and attempts to restore wires.
