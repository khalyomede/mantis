# Sessions

Mantis provides file-based session support for managing user state across requests.

## Configuration

Configure session handling in your application:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Session } // [!code focus]
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    session: Session{ // [!code focus:5]
      driver: .file
      path: "storage/sessions"  // Where session files are stored
      lifetime: 3600           // Session lifetime in seconds
    }
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

## Reading Session Data

Access session data using `session.get()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Session } // [!code focus]
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    session: Session{ // [!code focus:4]
      driver: .file
      path: "storage/sessions"
    }
    routes: [
      route.get(
        name: "preferences"
        path: "/preferences"
        callback: fn (app App) Response {
          theme := app.session.get("theme") or { "light" } // [!code focus]
          return response.html(content: "Current theme: ${theme}")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Writing Session Data

Store data in the session using `session.set()`:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Session } // [!code focus]
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    session: Session{ // [!code focus:4]
      driver: .file
      path: "storage/sessions"
    }
    routes: [
      route.post(
        name: "theme.update"
        path: "/theme"
        callback: fn (app App) Response {
          app.session.set("theme", "dark") or { // [!code focus:3]
            return response.html(content: "Could not save theme preference")
          }

          return response.html(content: "Theme updated")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Session Sliding

Session sliding automatically extends the session lifetime each time the user interacts with your application. This is useful for keeping users logged in as long as they're active:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Session } // [!code focus]
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    session: Session{ // [!code focus:6]
      driver: .file
      path: "storage/sessions"
      lifetime: 3600    // Session expires after 1 hour
      sliding: true     // Session lifetime is renewed on each request
    }
    routes: [
      route.get(
        name: "dashboard"
        path: "/dashboard"
        callback: fn (app App) Response {
          // Each request to dashboard will extend the session // [!code focus]
          return response.html(content: "Welcome to dashboard")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

::: warning
Session sliding involves **more writes on your disk** since each request will update the session data.
:::
