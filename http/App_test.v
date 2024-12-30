import json
import http { App, Route, Status, Request, Response, Session, SessionData, ErrorHandler, HttpError }
import http.response
import http.route
import logging { Log }
import logging.channel { File }
import test { expect, Fake }
import translation { Translation }
import os { getwd }
import time

const fake := Fake{}

fn test_serves_200_response_for_simple_get_route() {
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                name: "index"
                path: "/"
                callback: fn [content] (app App) Response {
                    return response.html(content: content)
                }
            )
        ],
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers["Content-Type"]).to_contain("text/html")
}

fn test_serves_200_response_for_route_with_parameters() {
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                name: "post.show",
                path: "/post/{post}",
                callback: fn [content] (app App) Response {
                    return response.html(content: content)
                }
            )
        ]
        request: Request{
            path: "/post/${fake.uuid.v4()}"
            method: .get
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to(content)
    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.headers["Content-Type"]).to_contain("text/html")
}

fn test_can_get_route_parameter() {
    comment_id := fake.uuid.v4()

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
            path: "/post/${fake.uuid.v4()}/comment/${comment_id}"
            method: .get
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("showing comment ${comment_id}")
}

fn test_can_get_query() {
    lang := fake.lang()

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
            method: .get
            path: "/"
            queries: {"lang": lang}
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to(lang)
}

fn test_can_set_response_headers() {
    company_name := fake.company.name()

    app := http.create_app(
        routes: [
            route.get(name: "index", path: "/", callback: fn [company_name] (app App) Response {
                return Response{
                    content: "hello"
                    headers: {
                        "X-Powered-By": [company_name]
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

    expect(res.headers["X-Powered-By"]).to_contain(company_name)
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
    user_name := fake.person.name()
    user_email := fake.email()

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
                "name": user_name
                "email": user_email
            }
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("${user_name} - ${user_email}")
}

fn test_can_retreive_session_data() {
    // Setup test session file
    session_id := fake.uuid.v4()
    user_id := fake.uuid.v4()
    session_data := SessionData{
        expires_at: time.now().unix() + 3600
        data: {
            "user_uuid": user_id
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
            id: session_id
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

    expect(res.content).to_be_equal_to("User uuid is ${user_id}.")

    // Clean up test files
    os.rmdir_all("misc/sessions") or {}
}

fn test_can_set_session_data() {
    // Setup test session directory
    user_id := fake.database.primary_key()
    session_id := "test-session-${user_id}"
    user_name := fake.person.name()
    os.mkdir_all("misc/sessions") or { panic(err) }

    // Initial session data
    initial_data := SessionData{
        expires_at: time.now().unix() + 3600
        data: {
            "name": user_name
        }
    }
    os.write_file("misc/sessions/${session_id}.json", json.encode(initial_data)) or {
        panic(err)
    }

    app := http.create_app(
        session: Session{
            driver: .file
            path: "misc/sessions"
            lifetime: 3600
            sliding: true
            id: session_id
        }
    )

    // Test setting new value
    app.session.set("user_id", user_id.str()) or { panic(err) }

    // Read file to verify changes
    content := os.read_file("misc/sessions/${session_id}.json") or { panic(err) }
    session_data := json.decode(SessionData, content) or { panic(err) }

    // Verify original data preserved and new data added
    expect(session_data.data["name"]).to_be_equal_to(user_name)
    expect(session_data.data["user_id"]).to_be_equal_to(user_id.str())

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

fn test_can_translate_text() {
    app := http.create_app(
        translation: Translation{
            keys: {
                "Welcome": {
                    .en: {
                        .neutral: {
                            .any: "Welcome"
                        }
                    }
                    .fr: {
                        .neutral: {
                            .any: "Bienvenue"
                        }
                    }
                }
            }
        }
        request: Request{
            path: "/"
            method: .get
        }
    )

    text := app.translation.translate(
        key: "Welcome"
        lang: .fr
    )

    expect(text).to_be_equal_to("Bienvenue")
}

fn test_can_set_different_port_number() {
    app := http.create_app(
        port: u16(3000)
        routes: [
            route.get(path: "/", callback: fn (app App) Response {
                return Response{
                    content: "hello world"
                }
            })
        ]
        request: Request{
            path: '/'
            method: .get
        }
    )

    res := app.render()

    expect(res.content).to_be_equal_to("hello world")
}

fn test_it_can_log_debug_info() {
    log_file_path := "misc/http_mantis.log"

    defer {
        os.rm(log_file_path) or {
            panic(err)
        }
    }

    mut app := App{
        log: Log{
            channel: File{
                path: log_file_path
            }
        }
    }

    data := fake.sentence()

    app.log.debug(data) or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with(data)
}
