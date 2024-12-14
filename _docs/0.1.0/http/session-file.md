# Sessions

Mantis provides file-based session support for managing user state across requests.

## Configuration

Configure session handling in your application:

```v
import mantis.http { create_app, App, Response, Session }
import mantis.http.route
import mantis.http.response

app := create_app(
  session: Session{
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
```

## Reading Session Data

Access session data using `session.get()`:

```v
import mantis.http { create_app, App, Response, Session }
import mantis.http.route
import mantis.http.response

app := create_app(
  session: Session{
    driver: .file
    path: "storage/sessions"
  }
  routes: [
    route.get(
      name: "preferences"
      path: "/preferences"
      callback: fn (app App) Response {
        theme := app.session.get("theme") or { "light" }
        return response.html(content: "Current theme: ${theme}")
      }
    )
  ]
)
```

## Writing Session Data

Store data in the session using `session.set()`:

```v
import mantis.http { create_app, App, Response, Session }
import mantis.http.route
import mantis.http.response

app := create_app(
  session: Session{
    driver: .file
    path: "storage/sessions"
  }
  routes: [
    route.post(
      name: "theme.update"
      path: "/theme"
      callback: fn (app App) Response {
        app.session.set("theme", "dark") or {
          return response.html(content: "Could not save theme preference")
        }

        return response.html(content: "Theme updated")
      }
    )
  ]
)
```

## Session Sliding

Session sliding automatically extends the session lifetime each time the user interacts with your application. This is useful for keeping users logged in as long as they're active:

```v
import mantis.http { create_app, App, Response, Session }
import mantis.http.route
import mantis.http.response

app := create_app(
  session: Session{
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
        // Each request to dashboard will extend the session
        return response.html(content: "Welcome to dashboard")
      }
    )
  ]
)
```

Note that the drawbacks is it involves **more writes on your disk** since each request will update the session data.
