# Type safety

Mantis uses V's built-in Result and Option types to handle errors and optional values in a type-safe way. This approach ensures that error cases must be explicitly handled, making your code more reliable.

## Option Type

Option types (written as `?Type`) represent values that may or may not exist:

```v
// A function that might not find what you're looking for
fn get_user_theme() ?string {
    // If not found, return none
    return "dark"
}

// Using the Option type
fn display_theme() string {
    // Must handle both cases
    theme := get_user_theme() or {
        return "light" // Default fallback
    }

    return theme
}
```

## Result Type

Result types (written as !Type) represent operations that might fail:

```v
// A function that could fail
fn save_post(title string) ! {
    if title.len == 0 {
        return error("Title cannot be empty")
    }

    // Success case just returns
    return
}

// Using the Result type
fn create_post() ! {
    // Must handle potential error
    save_post("My First Post") or {
        return error("Failed to save post: ${err.msg()}")
    }

    // Success!
}
```

## Why This Matters

This approach offers several benefits:

No Null Pointer Exceptions: Unlike languages with null, V's Option type forces you to handle the "not found" case
Explicit Error Handling: The ! type ensures you can't accidentally ignore errors
Compile-Time Safety: The compiler verifies that all error cases are handled
Clear Intent: The function signature clearly indicates if it can fail (!) or return nothing (?)

Here's a practical example from Mantis's routing:

```v
import mantis.http { create_app, App, Response }
import mantis.http.route
import mantis.http.response

app := create_app(
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

                // The ! indicates the database query might fail
                post := app.database.find("posts", id) or {
                    return response.html(
                        content: "Database error: ${err.msg()}",
                        status: .server_error
                    )
                }

                return response.html(content: "Post: ${post.title}")
            }
        )
    ]
)
```

This pattern ensures that:

Missing route parameters are handled gracefully
Database errors can't be ignored
The response type remains consistent
Error cases are explicit and visible

By using these types throughout, Mantis helps you write more reliable code while maintaining clarity and type safety.
