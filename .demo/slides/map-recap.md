---
theme: default
layout: default
---

# What does Map() do?

- Data Transformation
- Takes a collection (typically an array) and applies a callback function to every single element in it
- Returns a brand-new collection of the same length where each element has been replaced by whatever the callback returned for it.

# Key considerations

- Original collection is NEVER modified — map() returns a new collection
- Callback receives (item, index, array) — use what you need
- Never skips or adds elements, and always produces an output collection with exactly as many items as the input

---
layout: section
---


    