# Database

Learn how to use databases within your HTTP app.

::: tip Notice
Mantis currently only supports [SQLite](https://www.sqlite.org/) databases.
:::

## Configuration

Configure your database connection in your HTTP App:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.database { Database, DatabaseConnection } // [!code focus:6]

struct Post {
  id int
  title string
}

fn main() {
  app := create_app(
    database: Database{ // [!code focus:6]
      connection: DatabaseConnection{
        driver: .sqlite
        database: 'database.sqlite'
      }
    }
    routes: [
      route.get(
        name: "post.show"
        path: "/post/{id}"
        callback: fn (app App) !Response {
          // The ? indicates this might not find an ID
          id := app.route_parameter("id") or {
            return app.response.html(
              content: "Post not found",
              status: .not_found
            )
          }

          mut app_ref := app

          posts := app_ref.database.all[Post]("SELECT id, title FROM posts")! // [!code focus]

          post := posts[0] or {
            return app.response.html(
              content: "Post not found",
              status: .not_found
            )
          }

          return app.response.html(content: "Post (id ${id}): ${post.title}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
