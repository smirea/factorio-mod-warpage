# Solar Power (Blue Floor) Question

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/68bcec5ec114796fa090fd6a
- Thread ID: 68bcec5ec114796fa090fd6a
- Started by: pduncan4

---
**pduncan4 (op):** I feel like I'm missing something. I have unlocked the blue floor and put down solar panels but everything still seems to use my steam engine power first instead of the solar.

Am I missing something?

---
**theit8514:** This is usually how accumulators work in vanilla Factorio. The warpship console is just an accumulator that is shared across floors. You need to setup some logic so that your steam engines turn off when the accumulator is above a certain percentage (via the warpship console circuit). Then the solar floor will charge its accumulator which then spreads to the other floors.

---
**Ranec2:** If you search for SR latch on the main factorio wiki there are circuit blueprints for this.

---
**Copyrad:** Fair warning, the displayed accumulator charge (A) includes the ability charge, and how the number changes can be inconsistent and confusing. Nearly drove me mad trying to get the circuit right. Rush nuke FTW
