# Harvester combinators are replaced on recall

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6521fc941bb40e62480a28bd
- Thread ID: 6521fc941bb40e62480a28bd
- Started by: ArEyeses

---
**ArEyeses (op):** When recalling a harvester platform, the combinators are deleted and replaced with new blank combinators. This means that any wires connected to the previous combinators will also be deleted and any values in the combinators will also be gone.
(There is a previous locked thread about this issue, <https://mods.factorio.com/mod/warptorio2/discussion/6081bb92449c38110e20446e>. But I wanted to provide more detail and also a solution)

It seemed to me this could be fixed by not deleting the combinators, so I've looked into the code to find where this happens.
Firstly, near the end of `Harv::Recall`, you call `self:DestroyComboB()` which deletes the harvester-side combinator. I'm assuming this is in case a different platform has picked up the combinator? Are you able to check if the combinator has been recalled correctly and either only delete it if it is not; or preferably just move it back to its correct position?
Secondly, at the end of `Harv::Recall` you call `self:CheckCombo()`. This currently clears the space where the combinators should be (which will delete the old combinators, losing their wires and values) and places new combinators there. (How about using `isvalid` to check each combo before replacing it here?)

I would also like to mention, when a harvester upgrades it destroys both of its combinators. This is less of an issue if it only needs to be fixed then, since the belt connections also move so I'd need to rebuild anyway. However this means you don't have to worry about this when changing the recall code.

---
**PyroFire (mod author):** Did I not already fix this? :O Pretty sure I fixed this...

---
**NIKITAzed:** bump for this issue, additionally every once in a while the warp logistic chests get reset losing their filters and wire connections

---
**PoppuTheWeak:** With some luck, this is the same issue as the one mentioned in <https://mods.factorio.com/mod/warptorio2/discussion/66676b105553fe43a3b1e4be> and thus would be fixed at the same time?
