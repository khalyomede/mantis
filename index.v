module main

import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response
import mantis.database { Database, DatabaseConnection }

struct Post {
  id int
  title string
}

fn main() {
  app := create_app(
    database: Database{
      connection: DatabaseConnection{
        driver: .sqlite
        database: 'database.sqlite'
      }
    }
    routes: [
      route.get(
        name: "post.show"
        path: "/post/{id}"
        callback: fn (app App) Response {
          // The ? indicates this might not find an ID
          id := app.route_parameter("id") or {
            return response.html(
              content: "Post not found",
              status: .not_found
            )
          }

          mut app_ref := app

          // The ! indicates the database query might fail
          posts := app_ref.database.all[Post]("SELECT id, title FROM posts") or {
            return response.html(
              content: "Database error: ${err.msg()}",
              status: .server_error
            )
          }

          post := posts[0] or {
            return response.html(
              content: "Post not found",
              status: .not_found
            )
          }

          return response.html(content: "Post (id ${id}): ${post.title}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
