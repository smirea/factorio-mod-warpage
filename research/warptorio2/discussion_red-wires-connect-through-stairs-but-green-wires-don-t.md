# Red wires connect through stairs, but green wires don't

- URL: https://mods.factorio.com/mod/warptorio2/discussion/60839134db4271c6251da96f
- Thread ID: 60839134db4271c6251da96f
- Started by: deuscide

---
**deuscide (op):** It seems that red wires connect through stairs, but green wires don't. My setup: (1) Top platform: constant combinator signaling X=1, connected to stairs. (2) Factory floor: stairs connected to power pole. I did the above with both red and green wires. On the red wire, the factory floor pole reads X=1, A=200. (The A signal is from the stairs charge on both sides. On the green wire, the factory floor pole reads just A=100 (no X, and just the charge from one side of the stairs.) Version: 1.3.5

---
**PyroFire (mod author):** You're the first to report this.
As far as I am aware this should be working, you may have some other mods that interfered with it for whatever reason.

But easy to check, i'll do this when i touch the project next.

---
**giacobbe:** Hello. I have same problem like deuscide. I can use red wire but green do nothing. I can share my save if this help.

---
**ccsla:** I think I found why, this fixed it for me:

*control\_class\_teleporter.lua*
*L171:* p[2].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.green})
should most likely be:
*L171:* p[**1**].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.green})

---
**giacobbe:** :( this doesn't work for me. but thank you

---
**ccsla:** It should look like this (tested again and working on my side):

*control\_class\_teleporter.lua*:L168-173:
function TELL:ConnectCircuit() local p=self.points
if(self:ValidA() and self:ValidB())then
p[1].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.red})
p[*1*].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.green})
end
end

---
**giacobbe:** It works but i must start new game. thank you

---
**ccsla:** Glad you finally got it to work! You're welcome!

(But it's strange that you had to start a new save... I didn't had to.)
Anyway, enjoy!

---
**PyroFire (mod author):** > It should look like this (tested again and working on my side):
>
> *control\_class\_teleporter.lua*:L168-173:
> function TELL:ConnectCircuit() local p=self.points
> if(self:ValidA() and self:ValidB())then
> p[1].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.red})
> p[*1*].ent.connect\_neighbour({target\_entity=p[2].ent,wire=defines.wire\_type.green})
> end
> end

Very small typo, well done.
I'll need to add a migration to fix this for existing saves.

---
**ccsla:** Thank you! I just compared to a previous version I knew was working, nothing fancy.
Anyway, glad I could help!

---
**PyroFire (mod author):** This is fixed now, but added to list of flaws due to need for migration.

---
**PyroFire (mod author):** This is finished now
