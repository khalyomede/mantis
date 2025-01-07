# Request Handling

## Query Parameters

Access URL query parameters using `request.query()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route


fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "search"
        path: "/search"
        callback: fn (app App) !Response {
          query := app.request.query("q") or { // [!code focus:3]
            return app.response.html(content: "No search term provided")
          }

          return app.response.html(content: "Search results for: ${query}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Form Data

Access form data from POST requests using `request.form()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route


fn main() {
  app := create_app(
    routes: [
      route.post(
        name: "login.store"
        path: "/login"
        callback: fn (app App) !Response {
          email := app.request.form("email") or { // [!code focus:3]
            return app.response.html(content: "Email is required")
          }

          return app.response.html(content: "Logged in as ${email}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Cookies

Access cookie values using `request.cookies.get()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route


fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "dashboard"
        path: "/dashboard"
        callback: fn (app App) !Response {
          theme := app.request.cookies.get("theme") or { "light" } // [!code focus]

          return app.response.html(content: "Using ${theme} theme")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Client Information

Access the client's IP address using `request.ip`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route


fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "welcome"
        path: "/welcome"
        callback: fn (app App) !Response {
          return app.response.html(content: "Your IP is ${app.request.ip}") // [!code focus]
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
