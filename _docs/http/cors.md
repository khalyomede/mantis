# CORS

Learn how to configure Cross-Origin Resource Sharing (CORS) in your application.

## Basic Configuration

Configure CORS settings globally for your application:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Cors } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app_cors := Cors{ // [!code focus:5]
    allowed_origins: ['https://example.com']
    allowed_headers: ['Content-Type', 'Authorization']
    max_age_in_seconds: 7200 // 2 hours
  }

  app := create_app(
    cors: app_cors // [!code focus]
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) !Response {
          return app.response.html(content: "hello world")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}

```

:::

## Route-Specific CORS

Configure CORS settings for specific routes:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Cors } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    routes: [
      route.post(
        name: "api.users.store"
        path: "/api/users"
        cors: Cors{ // [!code focus:4]
          allowed_origins: ['https://admin.example.com']
          credentials: true
        }
        callback: fn (app App) !Response {
          return app.response.html(
            content: "User created"
            status: .created
          )
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Credentials Support

Enable credentials support for authenticated requests:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response, Cors } // [!code focus]
import khalyomede.mantis.http.route

fn main() {
  app_cors := Cors{
    credentials: true // [!code focus:2]
    allowed_origins: ['https://app.example.com'] // Required when credentials: true
  }

  app := create_app(
    cors: app_cors
    routes: [
      route.get(
        name: "api.profile"
        path: "/api/profile"
        callback: fn (app App) !Response {
          return app.response.html(content: "Profile data")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

::: warning
When `credentials` is enabled, you must specify exact allowed origins. Wildcard origins (`['*']`) are not allowed with credentials.
:::

## Automatic OPTIONS Handling

Mantis automatically handles OPTIONS requests by:

1. Setting appropriate CORS headers based on your configuration
2. Including allowed methods for the requested path
3. Validating requested headers against allowed headers
4. Setting proper max-age for browser caching

Example response headers:

```http
GET /api/v1/post/12 HTTP/1.1

HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: POST, PUT, DELETE
Access-Control-Allow-Headers: Content-Type, Authorization, Accept
Access-Control-Max-Age: 7200
Access-Control-Allow-Credentials: true
Allow: POST, PUT, DELETE
```

::: tip NOTICE
The Headers, Origin and Max-Age above are the default values.
:::
