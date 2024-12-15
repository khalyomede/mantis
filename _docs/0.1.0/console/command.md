# Commands

Commands are the building blocks of your CLI application. They define how your app responds to different command-line inputs.

## Basic Structure

A Command consists of several key components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet.show"          // Unique identifier
        description: "Displays a greeting message"
        signature: [                 // Command structure
          Name{"greet"}             // Command name in CLI
          Argument{
            name: "name"
            description: "Person to greet"
          }
        ]
        examples: [                  // Usage examples
          Example{
            description: "Greet someone"
            command: "greet John"
          }
        ]
        callback: fn (mut app App) Response {
          // Command logic here
          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

## Properties

### name

Unique identifier for the command. Often uses dot notation for grouping:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response }

fn main() {
  app := App{
    commands: [
      Command{
        name: "user.create" // [!code focus]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
      Command{
        name: "user.delete" // [!code focus]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

### description

A human-readable explanation of what the command does:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        description: "Displays a greeting message with optional formatting." // [!code focus]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

### signature

Defines the command's structure using several components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument, Flag, Opt }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        signature: [ // [!code focus:17]
          Name{"greet"} // command name, the first argument
          Argument{
            name: "name"
            description: "Person to greet"
          }
          Flag{ // -u, --uppercase
            long: "uppercase"
            short: "u"
            description: "Show in uppercase"
          }
          Opt{ // -s="value", --suffix="value"
            long: "suffix"
            short: "s"
            description: "Text to append"
          }
        ]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

### examples

Provides usage examples for your command:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Example }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        examples: [ // [!code focus:14]
          Example{
            description: "Basic greeting"
            command: "greet"
          }
          Example{
            description: "Greet with a name"
            command: "greet Alice"
          }
          Example{
            description: "Greet with options"
            command: 'greet Alice --suffix="and friends"'
          }
        ]
        callback: fn (mut app App) Response {
          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::

### callback

The function that executes when the command runs:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet"
        callback: fn (mut app App) Response { // [!code focus:7]
          name := app.arguments.get("name") or { "world" }

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

### Complete Example

Here's a command with all features combined:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { App, Command, Response, Name, Argument, Flag, Opt, Example }

fn main() {
  app := App{
    commands: [
      Command{
        name: "greet.show"
        description: "Displays a greeting message to someone."
        signature: [
          Name{"greet"}
          Argument{
            name: "name"
            description: 'The name of the person to greet (defaults to "world").'
          }
          Flag{
            long: "uppercase"
            short: "u"
            description: "Display the message in uppercase."
          }
          Opt{
            long: "suffix"
            short: "s"
            description: "Additional text to append after the greeting."
          }
        ]
        examples: [
          Example{
            description: "Greet everyone"
            command: "greet"
          }
          Example{
            description: "Greet someone"
            command: "greet Alice"
          }
          Example{
            description: "Greet with a suffix"
            command: 'greet Bob --suffix="and friends"'
          }
          Example{
            description: "Greet in uppercase"
            command: "greet Charlie --uppercase"
          }
        ]
        callback: fn (mut app App) Response {
          name := app.arguments.get("name") or { "world" }
          suffix := app.options.get("suffix") or { "" }

          mut message := "Hello ${name}${suffix}!"

          if app.has_flag("uppercase") {
            message = message.to_upper()
          }

          app.info(message)

          return app.exit(0)
        }
      }
    ]
  }

  app.serve()
}
```

:::
