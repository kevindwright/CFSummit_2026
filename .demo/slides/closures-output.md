---
theme: default
layout: default
---

# The three patterns above cover most of what you'll reach for day-to-day. 
To recap:
- Captured scope — the returned function holds a reference to variables from its birth context, not a copy. Change the outer variable after the fact and the closure sees the updated value.
- Encapsulated state — use a struct of closures as a lightweight alternative to a full CFC when you just need private state without the overhead of a component file.
- Callbacks — anywhere CFML accepts a function argument (arrayMap, arrayFilter, arraySort, arrayEach, structEach, etc.), closures make your code read naturally without scattering named helper functions all over the place.




---
layout: section
---


    