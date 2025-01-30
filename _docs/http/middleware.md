# Middleware

Middlewares are functions that you want to apply on many routes or globally which alter the response.

## Global middlewares

You can define middlewares to be applied before any route matching occurs. A middleware is much like a route and share the same signature.

### Before route matching

Here is a simple example showing how to change the header of all the routes, before the router tries to find a route.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Middlewares } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    middlewares: Middlewares{ // [!code focus:7]
      before_route_match: [
        fn (app App) !Response {
          return app.response.set_header("X-Powered-By", "Mantis")
        }
      ]
    }
    routes: [
      route.get(path: "/", callback: fn (app App) !Response {
        return app.response.html(content: "Hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Route middlewares

Middlewares can be declared on a route level for more fine-grain control.

### Before response rendered

You can modify the response right before it will be rendered.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, RouteMiddlewares } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.get(
        path: "/"
        middlewares: RouteMiddlewares{ // [!code focus:7]
          before_response_rendered: [
            fn (app App) !Response {
              return app.response.set_header("X-Powered-By", "Mantis")
            }
          ]
        }
        callback: fn (app App) !Response {
          return app.response.html(content: "Hello world")
        }
      )
    ]
  )
}
```

:::

::: tip NOTICE
Like routes, middlewares errors are catched and rendered/reported to the [error handler](/http/error-handling).
:::

### After response rendered

You can also alter the response after it has been rendered from your [route callback](/http/routing).

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, RouteMiddlewares } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.get(
        path: "/"
        middlewares: RouteMiddlewares{ // [!code focus:7]
          after_response_rendered: [
            fn (app App) !Response {
              return app.response.set_header("X-Powered-By", "Mantis")
            }
          ]
        }
        callback: fn (app App) !Response {
          return app.response.html(content: "Hello world")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

::: code-group
