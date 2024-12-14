# Routing

Routes define how your application responds to client requests.

## Basic Routes

Define routes in your application using `route.get()` or `route.post()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          return response.html(content: "hello world")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Route Parameters

Capture URL segments using parameters:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "post.show"
        path: "/post/{id}"
        callback: fn (app App) Response {
          id := app.route_parameter("id") or {
            return response.html(content: "Post not found")
          }

          return response.html(content: "Showing post ${id}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## HTTP Methods

Mantis supports GET and POST methods:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      // GET request
      route.get(
        name: "post.create"
        path: "/post/create"
        callback: fn (app App) Response {
          return response.html(content: "Create post form")
        }
      ),
      // POST request
      route.post(
        name: "post.store"
        path: "/post"
        callback: fn (app App) Response {
          return response.html(content: "Post created")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Multiple Parameters

Routes can have multiple parameters:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "post.comment"
        path: "/post/{post_id}/comment/{comment_id}"
        callback: fn (app App) Response {
          post_id := app.route_parameter("post_id") or {
            return response.html(content: "Post not found")
          }

          comment_id := app.route_parameter("comment_id") or {
            return response.html(content: "Comment not found")
          }

          return response.html(content: "Showing comment ${comment_id} on post ${post_id}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```
