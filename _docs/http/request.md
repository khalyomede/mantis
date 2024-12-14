# Request Handling

## Query Parameters

Access URL query parameters using `request.query()`:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "search"
      path: "/search"
      callback: fn (app App) Response {
        query := app.request.query("q") or {
          return response.html(content: "No search term provided")
        }

        return response.html(content: "Search results for: ${query}")
      }
    )
  ]
)
```

## Form Data

Access form data from POST requests using `request.form()`:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.post(
      name: "login.store"
      path: "/login"
      callback: fn (app App) Response {
        email := app.request.form("email") or {
          return response.html(content: "Email is required")
        }

        return response.html(content: "Logged in as ${email}")
      }
    )
  ]
)
```

## Cookies

Access cookie values using `request.cookies.get()`:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "dashboard"
      path: "/dashboard"
      callback: fn (app App) Response {
        theme := app.request.cookies.get("theme") or { "light" }

        return response.html(content: "Using ${theme} theme")
      }
    )
  ]
)
```

## Client Information

Access the client's IP address using `request.ip`:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "welcome"
      path: "/welcome"
      callback: fn (app App) Response {
        return response.html(content: "Your IP is ${app.request.ip}")
      }
    )
  ]
)
```
