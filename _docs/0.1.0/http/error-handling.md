# Error Handling

Mantis provides two main methods for handling errors in your application:

## handle_error

Use when you need to both report an error and return an error response:

```v
module main

import khalyomede.mantis.http { create_app, App, Response, HttpError }
import khalyomede.mantis.http.response
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        search := app.request.get("search") or {
          return app.handle_error(HttpError{ // [!code focus:4]
            code: .not_found
            message: "The search term was missing."
          })
        }

        return response.html(content: "You search is ${search}.")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

This will:
1. Report the error (e.g., log it)
2. Generate and return a response according to how the error handler is configured to render errors (see "Custom Error Handler" section to customize this behavior)

## report_error

Use when you need to log an error but want to continue processing:

```v
module main

import khalyomede.mantis.http { create_app, App, Response, ValidationError }
import khalyomede.mantis.http.response
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        theme := app.session.get("theme") or {
          app.report_error(ValidationError{ // [!code focus:3]
            message: 'Could not load user theme preferences, falling back to light mode'
          })

          "light"
        }

        return response.html(content: "Current theme: ${theme}")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

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

```v
module main

import khalyomede.mantis.http { create_app, App, Response, ErrorHandler }
import khalyomede.mantis.html { h1 }
import khalyomede.mantis.html { div, p }
import khalyomede.mantis.http.response
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
        return response.html(
          content: h1({}, ['Oops! Something went wrong'])
          status: .server_error
        )
      }
    }
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: div({}, ["Home page"]))
      })
    ]
  )

  app.serve() or { panic(err) }
}
```
