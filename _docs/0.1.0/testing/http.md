# Testing HTTP Applications

Mantis provides a robust way to test your HTTP applications using its built-in testing utilities.

## Basic Route Testing

Test simple route responses:

::: code-group
```v [tests/http/basic_test.v]
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.test { expect }

fn test_basic_route() {
  app := create_app(
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

  res := app.render()

  expect(res.status).to_be_equal_to(.ok)
  expect(res.content).to_be_equal_to("hello world")
  expect(res.headers).to_have_key_equal_to("Content-Type", ["text/html"])
}
```

:::

## Testing Route Parameters

Test routes with dynamic parameters:

::: code-group

```v [tests/http/basic_test.v]
fn test_route_with_parameters() {
  app := create_app(
    routes: [
      route.get(
        name: "post.show"
        path: "/post/{id}"
        callback: fn (app App) !Response {
          id := app.route_parameter("id") or {
            return app.response.html(
              content: "Post not found"
              status: .not_found
            )
          }

          return app.response.html(content: "Post ${id}")
        }
      )
    ],
    request: Request{
      path: "/post/123"
      method: .get
    }
  )

  res := app.render()

  expect(res.status).to_be_equal_to(.ok)
  expect(res.content).to_be_equal_to("Post 123")
}
```

:::

## Testing Form Submissions

Test POST requests with form data:

::: code-group

```v [tests/http/basic_test.v]
fn test_form_submission() {
  app := create_app(
    routes: [
      route.post(
        name: "login"
        path: "/login"
        callback: fn (app App) !Response {
          email := app.request.form("email") or {
            return app.response.html(
              content: "Email required"
              status: .bad_request
            )
          }

          return app.response.html(
            content: "Welcome ${email}"
            status: .created
          )
        }
      )
    ],
    request: Request{
      path: "/login"
      method: .post
      form: {
        "email": "user@example.com"
      }
    }
  )

  res := app.render()

  expect(res.status).to_be_equal_to(.created)
  expect(res.content).to_be_equal_to("Welcome user@example.com")
}
```

:::

## Testing Error Handling

Test how your application handles errors:

::: code-group

```v [tests/http/basic_test.v]
fn test_custom_error_handler() {
  app := create_app(
    error_handler: ErrorHandler{
      render: fn (app App, err IError) Response {
        return app.response.html(
          content: "Oops: ${err.msg()}"
          status: .server_error
        )
      }
    },
    routes: [
      route.get(
        name: "error"
        path: "/error"
        callback: fn (app App) !Response {
          return error(HttpError{
            code: .server_error
            message: "Something went wrong"
          })
        }
      )
    ],
    request: Request{
      path: "/error"
      method: .get
    }
  )

  res := app.render()

  expect(res.status).to_be_equal_to(.server_error)
  expect(res.content).to_be_equal_to("Oops: Something went wrong")
}
```

:::

## Testing Headers

Test response headers:

::: code-group

```v [tests/http/basic_test.v]
fn test_response_headers() {
  app := create_app(
    routes: [
      route.get(
        name: "api"
        path: "/api"
        callback: fn (app App) !Response {
          return Response{
            content: "API Response"
            headers: {
              "Content-Type": ["application/json"]
              "X-API-Version": ["1.0"]
            }
          }
        }
      )
    ],
    request: Request{
      path: "/api"
      method: .get
    }
  )

  res := app.render()

  expect(res.headers).to_have_key_equal_to("Content-Type", ["application/json"])
  expect(res.headers).to_have_key_equal_to("X-API-Version", ["1.0"])
}
```

:::
