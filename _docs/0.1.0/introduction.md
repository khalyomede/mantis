# Introduction

## What is Mantis?

Mantis is a web framework for V lang that prioritizes developer peace of mind through type safety and explicit code patterns. Built on the principle that code should be clear and predictable, Mantis helps you create web applications that are easy to maintain and scale.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.html { create_app, App, Response }
import khalyomede.mantis.html.route
import khalyomede.mantis.html.response

fn main() {
  app := create_app(
    mode: .standalone
    cpus: 8
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Why Another Framework?

Many web frameworks prioritize convenience through "magic" - implicit behaviors, runtime configurations, and hidden state. While this can speed up initial development, it often leads to maintenance headaches, runtime errors, and difficulty understanding the codebase as it grows.

Mantis takes a different approach:

- **Type Safety First**: From database queries to view templates, everything is type-checked at compile time
- **No Hidden Magic**: All behaviors are explicit and visible in your code
- **Function-Based Components**: Clear dependencies and pure functions make testing and maintenance easier
- **Predictable Request Flow**: See exactly how your requests are handled
- **Single Binary**: Your entire application, including views and configurations, compiles to a single executable

```v
// Type-safe database queries
struct Post {
    id int
    title string
    views u64
}

// The compiler ensures type safety
posts := db.all[Post]('SELECT id, title, views FROM posts')!
for post in posts {
    // post.title is guaranteed to be a string
    // post.views is guaranteed to be a u64
}
```

## Why V Lang?

V was chosen as the implementation language for several reasons:

- **Simplicity**: V's straightforward syntax and minimal feature set aligns with Mantis's philosophy
- **Performance**: V compiles to efficient machine code with minimal overhead
- **Safety**: V's strong type system and compile-time checks help catch errors early
- **Memory Safety**: No null pointers, no undefined behavior, no manual memory management
- **Fast Compilation**: V's rapid compilation speeds enable quick development cycles

## Core Philosophy

Mantis embraces several key principles:

1. **Explicit over Implicit**: Code should clearly show what it does without hidden behaviors
2. **Compile-time over Runtime**: Catch errors during compilation rather than in production
3. **Type Safety over Convenience**: A little extra typing is worth the peace of mind
4. **Simplicity over Complexity**: Features should be easy to understand and use
5. **Performance by Default**: Good performance should not require special optimization

## Is Mantis Right for You?

Mantis might be a good fit if you:

- Value code clarity and maintainability
- Want to catch errors at compile time rather than runtime
- Prefer explicit behaviors over "magic" convenience
- Need predictable performance without special optimization
- Are building a web application that needs to scale

However, Mantis might not be ideal if you:

- Need maximum development speed over maintainability
- Prefer convention over configuration
- Require extensive runtime configuration
- Need features that are still on our roadmap
