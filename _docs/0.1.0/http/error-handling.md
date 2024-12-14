# Error Handling

Mantis provides two main methods for handling errors in your application:

## handle_error

Use when you need to both report an error and return an error response:

```v
import khalyomede.mantis.http { HttpError }

return app.handle_error(HttpError{
  code: .not_found
  message: 'Page not found'
})
```

This will:
1. Report the error (e.g., log it)
2. Generate and return a response according to how the error handler is configured to render errors (see "Custom Error Handler" section to customize this behavior)

## report_error

Use when you need to log an error but want to continue processing:

```v
import khalyomede.mantis.http { ValidationError }
import khalyomede.mantis.http.response
import khalyomede.mantis.html { div, p }

// Report issue but continue with safe defaults for user settings
app.report_error(ValidationError{
  message: 'Could not load user theme preferences, falling back to light mode'
})

return response.html(content: div({}, [
  p({}, ['Welcome to the homepage'])
]))
```

## Error Types

Mantis provides built-in error types for common scenarios:

```v
import khalyomede.mantis.http { HttpError, ValidationError }

// For HTTP errors
HttpError{
  code: .not_found     // Status enum (.ok, .not_found, .server_error...)
  message: string      // Error message
}

// For validation errors
ValidationError{
  message: string      // Error message
}
```

## Content Types

The default error handler automatically detects and responds with the appropriate format:

```v
// Browser requests get HTML
Accept: text/html
=> HTML error page

// API requests get JSON
Accept: application/json
=> JSON error response
```

## Custom Error Handler

You can customize error handling by providing your own handler:

```v
import khalyomede.mantis.http { create_app, App, Response, ErrorHandler }
import khalyomede.mantis.html { h1 }

app := create_app(
  error_handler: ErrorHandler{
    report: fn (app App, err IError) {
      // Custom error reporting logic
      log_to_file(err.msg())
    }
    render: fn (app App, err IError) Response {
      // Custom error rendering logic
      return Response{
        content: h1({}, ['Oops! Something went wrong'])
        status: .server_error
        headers: {
          'Content-Type': ['text/html']
        }
      }
    }
  }
)
```
