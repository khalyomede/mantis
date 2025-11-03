# Option

Options are key-value pairs that accept input values.

## Basic Usage

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Opt }

fn main() {
  app := App{
    commands: [
      Command{
        name: "serve"
        signature: [
          Name{"serve"}
          Opt{ // [!code focus:5]
            long: "port"
            short: "p"
            description: "Port to listen on"
          }
        ]
        callback: fn (mut app App) Response {
          port := app.options.get("port") or { "8080" } // [!code focus]

          app.info("Starting server on port ${port}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Multiple Options

Commands can accept multiple options:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Opt }

fn main() {
  app := App{
    commands: [
      Command{
        name: "db"
        signature: [
          Name{"db"}
          Opt{ // [!code focus:15]
            long: "host"
            short: "h"
            description: "Database host"
          }
          Opt{
            long: "port"
            short: "p"
            description: "Database port"
          }
          Opt{
            long: "name"
            short: "n"
            description: "Database name"
          }
        ]
        callback: fn (mut app App) Response {
          host := app.options.get("host") or { "localhost" } // [!code focus:3]
          port := app.options.get("port") or { "5432" }
          name := app.options.get("name") or { "main" }

          app.info("Connecting to ${name} on ${host}:${port}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Options With Default Values

Show how to handle missing options with defaults:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Opt }

fn main() {
  app := App{
    commands: [
      Command{
        name: "deploy"
        signature: [
          Name{"deploy"}
          Opt{ // [!code focus:10]
            long: "env"
            short: "e"
            description: "Target environment"
          }
          Opt{
            long: "region"
            short: "r"
            description: "Deployment region"
          }
        ]
        callback: fn (mut app App) Response {
          env := app.options.get("env") or { "development" } // [!code focus:2]
          region := app.options.get("region") or { "us-east-1" }

          app.info("Deploying to ${env} in ${region}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Option Variants

Like flags, options can have long and/or short forms:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Opt }

fn main() {
  app := App{
    commands: [
      Command{
        name: "backup"
        signature: [
          Name{"backup"}
          Opt{ // [!code focus:13]
            long: "output"    // --output=file.zip
            short: "o"        // -o file.zip
            description: "Output file path"
          }
          Opt{
            long: "format"    // --format only
            description: "Archive format"
          }
          Opt{
            short: "c"        // -c only
            description: "Compression level"
          }
        ]
        callback: fn (mut app App) Response {
          output := app.options.get("output") or { "backup.zip" } // [!code focus:3]
          format := app.options.get("format") or { "zip" }
          level := app.options.get("c") or { "9" }

          app.info("Creating ${format} backup at ${output} with compression ${level}...")

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Options vs Flags

The key difference between Options and Flags:

Options require a value (`--port=8080`)

Flags are just boolean switches (`--verbose`)

Choose Options when you need to accept user input, and Flags when you just need to toggle behavior.
