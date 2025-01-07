# Responses

Mantis provides a simple way to return responses to clients.

## HTML Responses

Return HTML content using `response.html()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
 // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) !Response {
          return app.response.html(content: "hello world") // [!code focus]
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Status Codes

Set HTTP status codes using the `status` field:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Status }
import khalyomede.mantis.http.route
 // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.post(
        name: "post.store"
        path: "/post"
        callback: fn (app App) !Response {
          return app.response.html(
            content: "Post created successfully"
            status: .created // [!code focus:4]
          )
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Headers

Add custom headers to your response:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
 // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "cache.example"
        path: "/cached-page"
        callback: fn (app App) !Response {
          return app.response.html(
            content: "This page is cached"
            headers: { // [!code focus:3]
              'Cache-Control': ['max-age=3600']
            }
          )
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Redirects

Redirect users to another URL:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
 // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "profile"
        path: "/profile"
        callback: fn (app App) !Response {
          return app.response.redirect("/login", {}) // [!code focus]
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

You can also add query parameters:

::: code-group

```v [main.v]
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
 // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "admin"
        path: "/admin"
        callback: fn (app App) !Response {
          return app.response.redirect("/login", { // [!code focus:3]
            'return_to': '/admin'
          })
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
