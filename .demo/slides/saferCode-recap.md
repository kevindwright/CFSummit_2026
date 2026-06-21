---
theme: default
layout: default
---

# Why this matters beyond brevity

- The real win isn't fewer keystrokes
- Your code reads like what it does, not like defensive programming wrapped around what it does.
- Every isDefined() call is a place where the compiler can't help you. These operators let the language enforce null safety instead of putting it all on the developer

# A migration strategy

- Start by auditing any place you use isDefined() in a CFScript expression — most of those can become ?. or ?: immediately with no behavior change.


---
layout: section
---


    