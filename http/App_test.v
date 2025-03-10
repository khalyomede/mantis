import json
import http { App, Route, Status, Request, Response, Session, SessionData, ErrorHandler, HttpError, Cors, HeaderType, Mime, Middlewares, RouteMiddlewares }
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
                callback: fn [content] (app App) !Response {
                    return app.response.html(content: content)
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
                callback: fn [content] (app App) !Response {
                    return app.response.html(content: content)
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

fn test_serves_404_when_route_doesnt_matches_path() {
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                name: "index"
                path: "/"
                callback: fn [content] (app App) !Response {
                    return app.response.html(content: content)
                }
            )
        ],
        request: Request{
            path: "/todo/create"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.not_found)
    expect(res.content).to_be_equal_to("")
    expect(res.headers["Content-Type"]).to_contain("text/html")
}

fn test_can_get_route_parameter() {
    comment_id := fake.uuid.v4()

    app := http.create_app(
        routes: [
            route.get(
                name: "post.comment.edit",
                path: "/post/{post}/comment/{comment}",
                callback: fn (app App) !Response {
                    comment := app.route_parameter("comment") or { "" }

                    return app.response.html(content: "showing comment ${comment}")
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
            route.get(name: "index", path: "/", callback: fn (app App) !Response {
                lang := app.request.query("lang") or {
                    "en"
                }

                return app.response.html(content: lang)
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
            route.get(name: "index", path: "/", callback: fn [company_name] (app App) !Response {
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
            route.get(name: "index", path: "/", callback: fn (app App) !Response {
                return app.response.redirect(path: "/login", queries: {
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

    expect(res.headers[HeaderType.location.to_string()]).to_contain("/login?error=invalid_credentials&email=user%40example.com")
}

fn test_can_parse_form_body_in_post_request() {
    user_name := fake.person.name()
    user_email := fake.email()

    app := http.create_app(
        routes: [
            route.post(name: "login.store", path: "/login", callback: fn (app App) !Response {
                name := app.request.form("name") or { "" }
                email := app.request.form("email") or { "" }

                return app.response.html(content: "${name} - ${email}")
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
            route.get(name: "dashboard.index", path: "/dashboard", callback: fn (app App) !Response {
                user_uuid := app.session.get("user_uuid") or {
                    return app.response.html(status: .server_error)
                }

                return app.response.html(content: "User uuid is ${user_uuid}.")
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

fn test_it_returns_404_if_registered_route_does_not_match() {
    // TODO
}

fn test_returns_json_error_when_requested() {
    app := App{
        request: Request{
            path: '/not-found'
            method: .get
            headers: {
                HeaderType.accept.to_string(): [Mime.application_json.to_string()]
            }
        }
    }

    res := app.render()

    expect(res.status).to_be_equal_to(Status.not_found)
    expect(res.headers).to_have_key_equal_to(HeaderType.content_type.to_string(), [Mime.application_json.to_string()])
    expect(res.content).to_be_equal_to('')
}

fn test_can_use_custom_error_handler() {
    custom_handler := ErrorHandler{
        report: fn (app App, err IError) {
            // Custom reporting logic
        }
        render: fn (app App, err IError) Response {
            return app.response.html(
                content: 'Custom error: ${err.msg()}'
                status: .server_error
            )
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

    expect(res.headers).to_have_key_equal_to(HeaderType.content_type.to_string(), [Mime.text_html.to_string()])
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
        port: 3000
        routes: [
            route.get(path: "/", callback: fn (app App) !Response {
                return app.response.html(content: "hello world")
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

fn test_it_respond_to_put_route() {
    post_id := fake.database.primary_key()

    app := http.create_app(
        routes: [
            route.put(path: "/post/{post}", callback: fn (app App) !Response {
                id := app.route_parameter("post") or {
                    return app.response.html(status: .not_found)
                }

                return app.response.html(content: "post ${id} updated")
            })
        ]
        request: Request{
            method: .put
            path: "/post/${post_id}"
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to("post ${post_id} updated")
}

fn test_it_can_respond_to_patch_route() {
    comment_id := fake.database.primary_key()

    app := http.create_app(
        routes: [
            route.patch(path: "/post/{post}/comment/{comment}", callback: fn (app App) !Response {
                id := app.route_parameter("comment") or {
                    return app.response.html(status: .not_found)
                }

                return app.response.html(content: "comment ${id} modified")
            })
        ]
        request: Request{
            method: .patch
            path: "/post/${fake.database.primary_key()}/comment/${comment_id}"
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to("comment ${comment_id} modified")
}

fn test_it_can_respond_to_delete_route() {
    post_id := fake.database.primary_key()

    app := http.create_app(
        routes: [
            route.delete(path: "/post/{post}", callback: fn (app App) !Response {
                id := app.route_parameter("post") or {
                    return app.response.html(status: .not_found)
                }

                return app.response.html(content: "post ${id} deleted")
            })
        ]
        request: Request{
            method: .delete
            path: "/post/${post_id}"
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to("post ${post_id} deleted")
}

fn test_head_request_returns_same_headers_as_get_without_body() {
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                name: "index"
                path: "/"
                callback: fn [content] (app App) !Response {
                    return app.response.html(content: content)
                }
            )
        ]
        request: Request{
            path: "/"
            method: .head
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to("")
    expect(res.headers).to_have_key_equal_to("Content-Type", ["text/html"])
    expect(res.headers).to_have_key_equal_to("Content-Length", [content.len.str()])
}

fn test_options_request_returns_allowed_methods() {
    app := http.create_app(
        routes: [
            route.get(path: "/post/{id}", callback: fn (app App) !Response {
                return app.response.html(content: "post detail")
            }),
            route.put(path: "/post/{id}", callback: fn (app App) !Response {
                return app.response.html(content: "post updated")
            }),
            route.delete(path: "/post/{id}", callback: fn (app App) !Response {
                return app.response.html(content: "post deleted")
            })
        ],
        request: Request{
            path: "/post/12"
            method: .options
            headers: {
                'Origin': [fake.internet.base_url()]
            }
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.headers['Allow']).to_contain('GET, PUT, DELETE')
    expect(res.headers['Access-Control-Allow-Methods']).to_contain('GET, PUT, DELETE')
    expect(res.headers['Access-Control-Max-Age']).to_contain('7200')
    expect(res.headers['Access-Control-Allow-Origin']).to_contain('*')
}

fn test_options_with_credentials_requires_specific_origin() {
    allowed_origin := fake.internet.base_url()

    app_cors := Cors{
        credentials: true
        allowed_origins: [allowed_origin]
    }

    app := http.create_app(
        cors: app_cors
        routes: [route.get(path: "/", callback: fn (app App) !Response {
            return app.response.html(content: "hello world")
        })],
        request: Request{
            path: "/"
            method: .options
            headers: {
                'Origin': [allowed_origin]
            }
        }
    )

    res := app.render()

    expect(res.headers['Access-Control-Allow-Credentials']).to_contain('true')
    expect(res.headers['Access-Control-Allow-Origin']).to_contain(allowed_origin)
}

fn test_options_filters_requested_headers() {
    allowed_origin := fake.internet.base_url()

    app_cors := Cors{
        allowed_headers: ['Content-Type', 'Authorization']
    }

    app := http.create_app(
        cors: app_cors
        routes: [
            route.get(path: "/", callback: fn (app App) !Response {
                return app.response.html(content: "hello world")
            })
        ],
        request: Request{
            path: "/"
            method: .options
            headers: {
                'Origin': [allowed_origin]
                'Access-Control-Request-Headers': ['Content-Type, X-Custom-Header']
            }
        }
    )

    res := app.render()

    expect(res.headers['Access-Control-Allow-Headers']).to_contain('Content-Type')
    expect(res.headers['Access-Control-Allow-Headers']).to_not_contain('X-Custom-Header')
}

fn test_options_with_route_specific_cors() {
    app_origin := 'https://app.example.com'
    api_origin := 'https://api.example.com'

    app_cors := Cors{
        allowed_origins: [app_origin]
    }

    app := http.create_app(
        cors: app_cors
        routes: [
            route.get(
                path: "/api/users"
                cors: Cors{
                    allowed_origins: [api_origin]
                }
                callback: fn (app App) !Response {
                    return app.response.html(content: fake.sentence())
                }
            )
        ]
        request: Request{
            path: "/api/users"
            method: .options
            headers: {
                'Origin': [api_origin]
            }
        }
    )

    res := app.render()

    // Should use route-specific CORS settings
    expect(res.headers['Access-Control-Allow-Origin']).to_contain(api_origin)
    expect(res.headers['Access-Control-Allow-Origin']).to_not_contain(app_origin)
}

fn test_options_with_merged_cors_settings() {
    origin := fake.internet.base_url()
    custom_headers := ['X-Custom-Header']

    app_cors := Cors{
        credentials: true
        allowed_origins: [origin]
    }

    app := http.create_app(
        cors: app_cors
        routes: [
            route.get(
                path: "/api/users"
                cors: Cors{
                    allowed_headers: ['X-Custom-Header']
                }
                callback: fn (app App) !Response {
                    return app.response.html(content: "users list")
                }
            )
        ]
        request: Request{
            path: "/api/users"
            method: .options
            headers: {
                'Origin': [origin]
                'Access-Control-Request-Headers': ['X-Custom-Header']
            }
        }
    )

    res := app.render()

    // Should merge global origin with route-specific headers
    expect(res.headers['Access-Control-Allow-Origin']).to_contain(origin)
    expect(res.headers['Access-Control-Allow-Headers']).to_contain('X-Custom-Header')
}

fn test_it_can_apply_header_change_through_global_middleware_before_route_match() {
    x_powered_by := fake.company.name()
    content := fake.sentence()

    app := http.create_app(
        middlewares: Middlewares{
            before_route_match: [
                fn [x_powered_by] (app App) !Response {
                    return app.response.set_header("X-Powered-By", x_powered_by)
                }
            ]
        }
        routes: [
            route.get(path: "/", callback: fn [content] (app App) !Response {
                return app.response.html(content: content)
            })
        ]
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers).to_have_key_equal_to("X-Powered-By", [x_powered_by])
    expect(res.headers).to_have_key_equal_to(HeaderType.content_type.to_string(), [Mime.text_html.to_string()])
}

fn test_route_can_override_header_set_by_global_before_route_match_middleware() {
    x_powered_by := fake.company.name()
    content := fake.sentence()

    app := http.create_app(
        middlewares: Middlewares{
            before_route_match: [
                fn (app App) !Response {
                    return app.response.set_header("X-Powered-By", fake.company.name())
                }
            ]
        }
        routes: [
            route.get(path: "/", callback: fn [x_powered_by, content] (app App) !Response {
                return app.response.set_header("X-Powered-By", x_powered_by).html(content: content)
            })
        ]
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers).to_have_key_equal_to("X-Powered-By", [x_powered_by])
}

fn test_route_can_override_header_before_route_renders_response() {
    x_powered_by := fake.company.name()
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                path: "/"
                middlewares: RouteMiddlewares{
                    before_response_rendered: [
                        fn [x_powered_by] (app App) !Response {
                            return app.response.set_header("X-Powered-By", x_powered_by)
                        }
                    ]
                }
                callback: fn [content] (app App) !Response {
                    return app.response.html(content: content)
                }
            )
        ]
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers).to_have_key_equal_to("X-Powered-By", [x_powered_by])
}

fn test_after_response_middleware_can_alter_header_after_route_response() {
    content := fake.sentence()

    app := http.create_app(
        routes: [
            route.get(
                path: "/"
                middlewares: RouteMiddlewares{
                    after_response_rendered: [
                        fn (app App) !Response {
                            return app.response.set_header("X-Powered-By", "After")
                        }
                    ]
                }
                callback: fn [content] (app App) !Response {
                    return app.response
                        .set_header("X-Powered-By", "Before")
                        .html(content: content)
                }
            )
        ]
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers).to_have_key_equal_to("X-Powered-By", ["After"])
}

fn test_after_route_match_middleware_can_add_header() {
    x_powered_by := fake.company.name()
    content := fake.sentence()

    app := http.create_app(
        middlewares: Middlewares{
            after_route_match: [
                fn [x_powered_by] (app App) !Response {
                    return app.response.set_header("X-Powered-By", x_powered_by)
                }
            ]
        }
        routes: [
            route.get(path: "/", callback: fn [content] (app App) !Response {
                return app.response.html(content: content)
            })
        ]
        request: Request{
            path: "/"
            method: .get
        }
    )

    res := app.render()

    expect(res.status).to_be_equal_to(Status.ok)
    expect(res.content).to_be_equal_to(content)
    expect(res.headers).to_have_key_equal_to("X-Powered-By", [x_powered_by])
}
