---
theme: default
layout: default
---

# Benefits

- Dead simple concurrency — wrap a block in <cfthread> and it runs asynchronously. No need to wrestle with Java's Thread and Runnable classes directly, even though that's what's happening under the hood.
- Great for I/O-bound work — calling multiple APIs, hitting several databases, processing independent file operations

# Key considerations

- Scope gotchas — variables inside a thread don't share scope with the page the way you'd expect.
- Error handling is awkward — exceptions thrown inside a thread don't bubble up the way you expect; you have to check cfthread[name].status and handle errors explicitly.
- CPU overload — it's still bound by the JVM and your CF server's thread pool settings
---
layout: section
---


    