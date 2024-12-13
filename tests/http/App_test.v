import json
import mantis.http { App, Route, Status, Request, Response, Session, SessionData, ErrorHandler, HttpError }
import mantis.http.response
import mantis.http.route
import mantis.test { expect }
import os { getwd }
import time

fn test_serves_200_response_for_simple_get_route() {
    app := http.create_app(
        routes: [
            Route{name: "index", path: "/", callback: fn (app App) Response {
                return response.html(content: "hello world")
            }}
        ],
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to("hello world")
    expect(res.headers["Content-Type"]).to_contain("text/html")
}

fn test_serves_200_response_for_route_with_parameters() {
    app := http.create_app(
        routes: [
            route.get(
                name: "post.show",
                path: "/post/{post}",
                callback: fn (app App) Response {
                    return response.html(content: "post details")
                }
            )
        ]
        request: Request{
            path: "/post/25c1c7bfc6514c84b5a7148389e22c84"
            method: .get
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("post details")
    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.headers["Content-Type"]).to_contain("text/html")
}

fn test_can_get_route_parameter() {
    app := http.create_app(
        routes: [
            route.get(
                name: "post.comment.edit",
                path: "/post/{post}/comment/{comment}",
                callback: fn (app App) Response {
                    comment := app.route_parameter("comment") or { "" }
                    return response.html(content: "showing comment ${comment}")
                }
            )
        ]
        request: Request{
            path: "/post/25c1c7bfc6514c84b5a7148389e22c84/comment/a90ede34f14645bc90aed2db39907b97"
            method: .get
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("showing comment a90ede34f14645bc90aed2db39907b97")
}

fn test_can_get_query() {
    app := http.create_app(
        routes: [
            route.get(name: "index", path: "/", callback: fn (app App) Response {
                lang := app.request.query("lang") or {
                    "en"
                }

                return response.html(content: lang)
            })
        ],
        request: Request{
            path: "/"
            queries: {"lang": "fr"}
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("fr")
}

fn test_can_set_response_headers() {
   app := http.create_app(
        routes: [
            route.get(name: "index", path: "/", callback: fn (app App) Response {
                return Response{
                    content: "hello"
                    headers: {
                        "X-Powered-By": ["Mantis"]
                    }
                }
            })
        ],
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.headers["X-Powered-By"]).to_contain("Mantis")
}

fn test_can_redirect_to_url_with_query_parameters() {
    app := http.create_app(
        routes: [
            route.get(name: "index", path: "/", callback: fn (app App) Response {
                return response.redirect("/login", {
                    "error": "invalid_credentials"
                    "email": "user@example.com"
                })
            })
        ],
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.headers["Location"]).to_contain("/login?error=invalid_credentials&email=user%40example.com")
}

fn test_can_parse_form_body_in_post_request() {
    app := http.create_app(
        routes: [
            route.post(name: "login.store", path: "/login", callback: fn (app App) Response {
                name := app.request.form("name") or { "" }
                email := app.request.form("email") or { "" }
                return response.html(content: "${name} - ${email}")
            })
        ],
        request: Request{
            path: "/login"
            method: .post
            form: {
                "name": "John Doe"
                "email": "john@example.com"
            }
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("John Doe - john@example.com")
}

fn test_can_retreive_session_data() {
    // Setup test session file
    session_id := "e647b6d6-42a4-4a23-9e9b-99c6a851ccba"
    session_data := SessionData{
        expires_at: time.now().unix() + 3600
        data: {
            "user_uuid": "8fa97b8a-e840-4316-87ba-ad0c528eafba"
        }
    }

    os.mkdir_all("misc/sessions") or { panic(err) }
    os.write_file("misc/sessions/${session_id}.json", json.encode(session_data)) or {
        panic(err)
    }

    app := http.create_app(
        session: Session{
            driver: .file
            path: "misc/sessions"
            lifetime: 3600
            sliding: true
            id: "e647b6d6-42a4-4a23-9e9b-99c6a851ccba"
        },
        routes: [
            route.get(name: "dashboard.index", path: "/dashboard", callback: fn (app App) Response {
                user_uuid := app.session.get("user_uuid") or { return response.html(status: .server_error) }
                return response.html(content: "User uuid is ${user_uuid}.")
            })
        ],
        request: Request{
            path: "/dashboard"
            method: .get
            headers: {
                "Cookie": ["session_id=${session_id};"]
            }
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("User uuid is 8fa97b8a-e840-4316-87ba-ad0c528eafba.")

    // Clean up test files
    os.rmdir_all("misc/sessions") or {}
}

fn test_returns_404_for_missing_route() {
    app := App{
        request: Request{
            path: '/not-found'
            method: .get
            headers: {
                'Accept': ['text/html']
            }
        }
    }

    res := app.render()

    expect(res.status).to_be_equal_to(Status.not_found)
    expect(res.headers).to_have_key_equal_to('Content-Type', ['text/html'])
    expect(res.content).to_be_equal_to('')
}

fn test_returns_json_error_when_requested() {
    app := App{
        request: Request{
            path: '/not-found'
            method: .get
            headers: {
                'Accept': ['application/json']
            }
        }
    }

    res := app.render()

    expect(res.status).to_be_equal_to(Status.not_found)
    expect(res.headers).to_have_key_equal_to('Content-Type', ['application/json'])
    expect(res.content).to_be_equal_to('')
}

fn test_can_use_custom_error_handler() {
    custom_handler := ErrorHandler{
        report: fn (app App, err IError) {
            // Custom reporting logic
        }
        render: fn (app App, err IError) Response {
            return Response{
                content: 'Custom error: ${err.msg()}'
                status: .server_error
            }
        }
    }

    app := App{
        error_handler: custom_handler
        request: Request{
            path: '/not-found'
            method: .get
        }
    }

    res := app.render()

    expect(res.content).to_be_equal_to('Custom error: Route not found')
}

fn test_handle_error_reports_and_renders_error() {
    custom_handler := ErrorHandler{
        report: fn (app App, err IError) {
            //
        }
        render: fn (app App, err IError) Response {
            return Response{
                content: err.msg()
                status: .server_error
            }
        }
    }

    app := http.create_app(
        error_handler: custom_handler
        request: Request{
            path: "/"
            method: .get
        }
    )

    test_error := HttpError{
        code: .not_found
        message: 'Test error'
    }

    res := app.handle_error(test_error)

    expect(res.content).to_be_equal_to('Test error')
    expect(res.status).to_be_equal_to(Status.server_error)
}
