# Flag

Flags are boolean switches that modify command behavior.

## Basic Usage

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Flag }

fn main() {
  app := App{
    commands: [
      Command{
        name: "build"
        signature: [
          Name{"build"}
          Flag{ // [!code focus:5]
            long: "verbose"
            short: "v"
            description: "Show detailed output"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("verbose") { // [!code focus:3]
            app.info("Running build in verbose mode...")
          }

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Multiple Flags

Commands can accept multiple flags:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Flag }

fn main() {
  app := App{
    commands: [
      Command{
        name: "test"
        signature: [
          Name{"test"}
          Flag{ // [!code focus:10]
            long: "watch"
            short: "w"
            description: "Watch for file changes"
          }
          Flag{
            long: "fail-fast"
            short: "f"
            description: "Stop on first failure"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("watch") { // [!code focus:7]
            app.info("Watching for changes...")
          }

          if app.has_flag("fail-fast") {
            app.info("Will stop on first failure")
          }

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Help Flag

It's common to add a help flag to display command usage:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Flag }

fn main() {
  app := App{
    commands: [
      Command{
        name: "serve"
        signature: [
          Name{"serve"}
          Flag{ // [!code focus:5]
            long: "help"
            short: "h"
            description: "Display help information"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("help") { // [!code focus:4]
            app.info(app.help_text())
            return app.exit(0)
          }

          app.info("Starting server...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Flag Variants

Flags can have long and/or short forms:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Flag }

fn main() {
  app := App{
    commands: [
      Command{
        name: "migrate"
        signature: [
          Name{"migrate"}
          Flag{ // [!code focus:13]
            long: "force"      // --force
            short: "f"         // -f
            description: "Force migration without confirmation"
          }
          Flag{
            long: "fresh"      // --fresh only
            description: "Drop all tables before migrating"
          }
          Flag{
            short: "p"         // -p only
            description: "Show migration progress"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("force") { // [!code focus:3]
            app.info("Forcing migration...")
          }

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::
