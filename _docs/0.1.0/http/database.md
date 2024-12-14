# Database

Learn how to use databases within your HTTP app.

::: tip Notice
Mantis currently only supports SQLite databases.
:::

## Configuration

Configure your database connection in your HTTP App:

```v
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.database { DatabaseConnection } // [!code focus]

fn main() {
  app := create_app(
    database: Database{ // [!code focus:7]
      connection: DatabaseConnection{
        by_default: true
        driver: .sqlite
        database: 'blog.db'
      }
    }
    routes: [
      route.get(
        name: "post.show"
        path: "/post/{id}"
        callback: fn (app App) Response {
          struct Post { // [!code focus:5]
            id int
            title string
            views u64
          }

          id := app.route_parameter("id") or {
            return response.html(
              content: "Post not found"
              status: .not_found
            )
          }

          posts := app.database.all[Post](' // [!code focus:11]
            SELECT id, title, views
            FROM posts
            WHERE id = ${id}
            LIMIT 1
          ') or {
            return response.html(
              content: "Database error: ${err.msg()}"
              status: .server_error
            )
          }

          if posts.len == 0 {
            return response.html(
              content: "Post not found"
              status: .not_found
            )
          }

          return response.html(
            content: "Post: ${posts[0].title}"
          )
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
