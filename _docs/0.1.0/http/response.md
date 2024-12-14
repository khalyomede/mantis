# Responses

Mantis provides a simple way to return responses to clients.

## HTML Responses

Return HTML content using `response.html()`:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

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
```

## Status Codes

Set HTTP status codes using the `status` field:

```v
import mantis.http { create_app, App, Response, Status }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.post(
      name: "post.store"
      path: "/post"
      callback: fn (app App) Response {
        return response.html(
          content: "Post created successfully"
          status: .created
        )
      }
    )
  ]
)
```

## Headers

Add custom headers to your response:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "cache.example"
      path: "/cached-page"
      callback: fn (app App) Response {
        return response.html(
          content: "This page is cached"
          headers: {
            'Cache-Control': ['max-age=3600']
          }
        )
      }
    )
  ]
)
```

## Redirects

Redirect users to another URL:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "profile"
      path: "/profile"
      callback: fn (app App) Response {
        return response.redirect("/login")
      }
    )
  ]
)
```

You can also add query parameters:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
  routes: [
    route.get(
      name: "admin"
      path: "/admin"
      callback: fn (app App) Response {
        return response.redirect("/login", {
          'return_to': '/admin'
        })
      }
    )
  ]
)
```
