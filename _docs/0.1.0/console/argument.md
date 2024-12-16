# Argument

Arguments are positional values passed to your commands.

## Basic Usage

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        signature: [
          Name{"greet"}
          Argument{ // [!code focus:4]
            name: "name"
            description: "Name to greet"
          }
        ]
        callback: fn (mut app App) Response {
          // Get argument value
          name := app.arguments.get("name") or { "world" } // [!code focus]

          app.info("Hello ${name}!")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Optional Arguments

Arguments can have default values when not provided:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument }

fn main() {
  app := App{
    commands: [
      Command{
        name: "deploy"
        signature: [
          Name{"deploy"}
          Argument{ // [!code focus:4]
            name: "environment"
            description: "Target environment (defaults to development)"
          }
        ]
        callback: fn (mut app App) Response {
          env := app.arguments.get("environment") or { "development" } // [!code focus]

          app.info("Deploying to ${env}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Multiple Arguments

Commands can accept multiple arguments:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument }

fn main() {
  app := App{
    commands: [
      Command{
        name: "copy"
        signature: [
          Name{"copy"}
          Argument{ // [!code focus:8]
            name: "source"
            description: "Source file"
          }
          Argument{
            name: "destination"
            description: "Destination path"
          }
        ]
        callback: fn (mut app App) Response {
          source := app.arguments.get("source") or { // [!code focus:9]
            app.info("Source file required")

            return app.exit(1)
          }

          destination := app.arguments.get("destination") or {
            app.info("Destination path required")

            return app.exit(1)
          }

          app.info("Copying ${source} to ${destination}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::
