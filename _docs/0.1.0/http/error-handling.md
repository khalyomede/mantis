# Error Handling

Mantis provides two main methods for handling errors in your application:

## Handling error

All routes callbacks have the `!` before `!Response`, indicating you can bubble errors without having to explicitly call the error handler: any error bubbled will be handled by your error handler.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.validation { validate, Min, Value, Rule }

fn main() {
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) !Response {
        search := app.request.query("search") or { "" }

        data := {
          "search": Value(search)
        }

        rules := {
          "search": [
            Rule(Min{3})
          ]
        }

        validate(data, rules)! // any errors will be rendered/reported // [!code focus]

        return app.response.html(content: "You search is ${search}.")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

This will:
1. Report the error (e.g., log it)
2. Generate and return a response according to how the error handler is configured to render errors (see the [custom error handler](#custom-error-handler) section)

::: tip NOTICE
Refer to V documentation about the [built-in error type](https://docs.vlang.io/type-declarations.html#optionresult-types-and-error-handling) for more information.
:::

## report_error

Use when you need to log an error but want to continue processing:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, HttpError } // [!code:focus]
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) !Response {
        theme := app.session.get("theme")! // [!code focus]

        return app.response.html(content: "Current theme: ${theme}")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Error Types

Mantis provides built-in error types for common scenarios:

```v
import khalyomede.mantis.http { HttpError, ValidationError }

// For HTTP errors
HttpError{
  code: .not_found     // Status enum (.ok, .not_found, .server_error...)
  message: string      // Error message
}

// For validation errors
ValidationError{
  message: string      // Error message
}
```

## Content Types

The default error handler automatically detects and responds with the appropriate format:

```v
// Browser requests get HTML
Accept: text/html
=> HTML error page

// API requests get JSON
Accept: application/json
=> JSON error response
```

## Custom Error Handler

You can customize error handling by providing your own handler:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, ErrorHandler } // [!code focus]
import khalyomede.mantis.html { h1, div, p }
import khalyomede.mantis.http.route
import khalyomede.mantis.console

fn main() {
  app := create_app(
    error_handler: ErrorHandler{ // [!code focus:13]
      report: fn (app App, err IError) {
        // Custom error reporting logic
        console.error(err.msg())
      }
      render: fn (app App, err IError) Response {
        // Custom error rendering logic
        return app.response.html(
          content: h1({}, ['Oops! Something went wrong'])
          status: .server_error
        )
      }
    }
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) !Response {
        return app.response.html(content: div({}, ["Home page"]))
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
