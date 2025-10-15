# Error Handling

Errors can be handled on a central place if you need to report and render errors in a consistent way.

## Automatic error reporting

All routes and [middlewares](/http/middleware) callbacks have the `!` before `!Response`, indicating uncatched errors will be passed to your error handler.

For example, when validating data, instead of manual error handling, you can just let it fail. The error handler will take care of any unhandled errors.

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
2. Render the error (according to how the error handler has been configured, see the [custom error handler](#custom-error-handler) section) and return it

::: tip NOTICE
Refer to V documentation about the [built-in error type](https://docs.vlang.io/type-declarations.html#optionresult-types-and-error-handling) for more information.
:::

## Erorr reporting

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
        theme := app.session.get("theme") or { // [!code focus:2]
          app.erorr_handler.report(err) // Just log it, no rendering

          "light" // default value
        }

        return app.response.html(content: "Current theme: ${theme}")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Custom Error Handler

By default a simple error handler is configured, which will return blank errors (with no styling) and log in the server console any errors.

You can customize the error handler by providing your own like following:

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
