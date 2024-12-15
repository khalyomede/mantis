# Testing Console Applications

Mantis provides utilities to test your command-line applications thoroughly.

## Basic Command Testing

Test simple command responses:

::: code-group
```v [tests/console/basic_test.v]
import mantis.console { App, Command, Response }
import mantis.test { expect }

fn test_basic_command() {
  app := App{
    commands: [
      Command{
        name: "greet"
        callback: fn (mut app App) Response {
          app.info("Hello world")

          return app.exit(0)
        }
      }
    ]
  }

  res := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(res.code).to_be_equal_to(0)
  expect(res.output).to_be_equal_to("Hello world")
}
```

:::

## Testing Command Arguments

Test commands with arguments:

::: code-group

```v [tests/console/basic_test.v]
fn test_command_with_arguments() {
  app := App{
    commands: [
      Command{
        name: "greet"
        signature: [
          Name{"greet"}
          Argument{
            name: "name"
            description: "Name of the person to greet"
          }
        ]
        callback: fn (mut app App) Response {
          name := app.arguments.get("name") or { "world" }
          app.info("Hello ${name}")

          return app.exit(0)
        }
      }
    ],
    console_signature: [
      Program{name: "app"}
      Name{name: "greet"}
      Argument{
        name: "name"
        value: "John"
      }
    ]
  }

  res := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(res.code).to_be_equal_to(0)
  expect(res.output).to_be_equal_to("Hello John")
}
```

:::

## Testing Flags

Test command flags:

::: code-group

```v [tests/console/basic_test.v]
fn test_command_with_flags() {
  app := App{
    commands: [
      Command{
        name: "build"
        signature: [
          Name{"build"}
          Flag{
            long: "production"
            short: "p"
            description: "Build for production"
          }
        ]
        callback: fn (mut app App) Response {
          mode := if app.has_flag("production") {
            "production"
          } else {
            "development"
          }

          app.info("Building in ${mode} mode")

          return app.exit(0)
        }
      }
    ],
    console_signature: [
      Program{name: "app"}
      Name{name: "build"}
      Flag{long: "production"}
    ]
  }

  res := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(res.code).to_be_equal_to(0)
  expect(res.output).to_be_equal_to("Building in production mode")
}
```

:::

## Testing Help Text

Test command help text generation:

::: code-group

```v [tests/console/basic_test.v]
fn test_help_text() {
  app := App{
    commands: [
      Command{
        name: "greet"
        description: "Displays a greeting message"
        signature: [
          Name{"greet"}
          Argument{
            name: "name"
            description: "Name of the person to greet"
          }
          Flag{
            long: "uppercase"
            short: "u"
            description: "Display in uppercase"
          }
        ]
        examples: [
          Example{
            description: "Greet someone"
            command: "greet John"
          }
        ]
        callback: fn (mut app App) Response {
          if app.has_flag("help") {
            app.info(app.help_text())
            return app.exit(0)
          }
          return app.exit(0)
        }
      }
    ],
    console_signature: [
      Program{name: "app"}
      Name{name: "greet"}
      Flag{long: "help"}
    ]
  }

  res := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(res.code).to_be_equal_to(0)
  expect(res.output).to_be_equal_to([
    "Displays a greeting message"
    ""
    "Usage:"
    ""
    "  greet [name] [...flags]"
    ""
    "Arguments:"
    ""
    "  name: Name of the person to greet"
    ""
    "Flags:"
    ""
    "  --uppercase, -u: Display in uppercase"
    ""
    "Examples:"
    ""
    "  Greet someone"
    "    greet John"
  ].join("\n"))
}
```

:::

## Testing Error Cases

Test how commands handle errors:

::: code-group

```v [tests/console/basic_test.v]
fn test_command_error() {
  app := App{
    commands: [
      Command{
        name: "deploy"
        signature: [
          Name{"deploy"}
          Argument{
            name: "environment"
            description: "Environment to deploy to"
          }
        ]
        callback: fn (mut app App) Response {
          environment := app.arguments.get("environment") or {
            app.info("Environment is required")
            return app.exit(1)
          }

          return app.exit(0)
        }
      }
    ],
    console_signature: [
      Program{name: "app"}
      Name{name: "deploy"}
    ]
  }

  res := app.render() or {
    Response{
      output: ""
      code: 1
    }
  }

  expect(res.code).to_be_equal_to(1)
  expect(res.output).to_be_equal_to("Environment is required")
}
```

:::
