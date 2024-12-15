# Routing

Learn how to create CLI commands and handle user input.

## Basic Command

Create a simple hello world command:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        signature: [
          Name{"greet"}
        ]
        callback: fn (mut app App) Response {
          app.info("Hello world!")

          return app.exit(0)
        }
      }
    ]
  }

  app.render() or { panic(err) }
}
```

:::

```bash
v run main.v greet
# 2024-12-15T12:22:08.000000000Z [INFO] Hello world!
```

## Exit Codes

Return meaningful exit codes to indicate success or failure:

::: code-group

```v{19,24} [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name }

fn main() {
  app := App{
    commands: [
      Command{
        name: "deploy"
        signature: [
          Name{"deploy"}
        ]
        callback: fn (mut app App) Response {
          app.info("Starting deployment...")

          if false { // Simulate a deployment error
            app.error("Deployment failed")

            return app.exit(1)
          }

          app.info("Deployed successfully!")

          return app.exit(0)
        }
      }
    ]
  }

  app.render() or { panic(err) }
}
```

:::

```bash
v run main.v deploy
# 2024-12-15T12:22:08.000000000Z [INFO] Starting deployment...
# 2024-12-15T12:22:08.000000000Z [ERRO] Deployment failed
echo $? # Print the last exit code
# 1
```

## Logging

Use different log levels to provide meaningful feedback:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name }

fn main() {
  app := App{
    commands: [
      Command{
        name: "backup"
        signature: [
          Name{"backup"}
        ]
        callback: fn (mut app App) Response {
          app.info("Starting backup...") // [!code focus:3]
          app.debug("Checking disk space")
          app.error("Permission denied")

          return app.exit(1)
        }
      }
    ]
  }

  app.render() or { panic(err) }
}
```

:::

```bash
v run main.v backup
# 2024-12-15T12:22:08.000000000Z [INFO] Starting backup...
# 2024-12-15T12:22:08.000000000Z [DBUG] Checking disk space
# 2024-12-15T12:22:08.000000000Z [ERRO] Permission denied
```

## Help Text

Display help instructions for your commands:

::: code-group

```v{20-24} [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Flag }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        description: "Display a friendly message"
        signature: [
          Name{"greet"}
          Flag{
            long: "help"
            short: "h"
            description: "Display help instructions"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("help") {
            app.info(app.help_text())

            return app.exit(0)
          }

          app.info("Hello world!")

          return app.exit(0)
        }
      }
    ]
  }

  app.render() or { panic(err) }
}
```

:::

```bash
v run main.v greet --help
# 2024-12-15T12:22:08.000000000Z [INFO] Display a friendly message
#
# Usage:
#
#   greet [...flags]
#
# Flags:
#
#   --help, -h: Display help instructions
```

### Testing Commands

Exit codes make it easy to test your commands:

::: code-group

```v [tests/commands/greet_test.v]
module commands

import khalyomede.mantis.console { App, Command, Response, Name }
import khalyomede.mantis.test { expect }

fn test_greet_command_returns_success_code() {
  app := App{
    commands: [
      Command{
        name: "greet"
        signature: [
          Name{"greet"}
        ]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
    ]
  }

  response := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(response.code).to_be_equal_to(0)
}
```

:::
