module http

import console
import env { Env }
import validation { Rule, Min, Max, Value }
import database { Database }
import translation { Translation }
import net
import rand
import time
import regex

pub struct App {
    pub:
        port u16 = 80
        host string = "0.0.0.0"
        routes []Route
        request Request
        mode ServeMode
        cpus u8 = 1
        session Session
        error_handler ErrorHandler = default_error_handler()
        translation Translation

    pub mut:
        env Env
        database Database
}

pub fn (app App) route_parameter(key string) ?string {
    route := app.find_route() ?

    parameters := route.parameters(app.request.path) or { map[string]string{} }

    return parameters[key] or {
        none
    }
}

fn (app App) address() string {
    return "${app.host}:${app.port}"
}

pub fn (app App) serve()! {
    app.validate_options()!

    console.info("listening on ${app.address()}")

    match app.mode {
        .standalone {
            app.serve_in_standalone_mode()!
        }
    }
}

pub fn (app App) route(name string, parameters map[string]string) ?string {
    for route in app.routes {
        if route.name == name {
            return route.path
        }
    }

    return none
}

pub fn (app App) handle_error(err IError) Response {
    app.error_handler.report(app, err)
    return app.error_handler.render(app, err)
}

pub fn (app App) report_error(err IError) {
    app.error_handler.report(app, err)
}

struct CreateRequestParameters {
    method string @[required]
    path string @[required]
    ip string @[required]
    http_version string @[required]
    headers map[string][]string
}

fn create_request(parameters CreateRequestParameters) Request {
    mut cookies := map[string]string{}

    for key, values in parameters.headers {
        if key != "Cookie" {
            continue
        }

        for value in values {
            cookie_items := value.split(";")

            for cookie_item in cookie_items {
                key_value := cookie_item.split("=")
                cookie_item_key := key_value[0] or { "" }
                cookie_item_value := key_value[1] or { "" }

                if cookie_item_key.trim_space().len == 0 || cookie_item_value.trim_space().len == 0 {
                    continue
                }

                cookies[cookie_item_key] = cookie_item_value
            }
        }

        break
    }

    return Request{
        method: parse_method(parameters.method)
        path: parse_path(parameters.path) or { parameters.path }
        ip: parameters.ip
        http_version: parameters.http_version
        queries: parse_queries(parameters.path)
        headers: parameters.headers
        cookies: cookies
    }
}

fn parse_path(path string) !string {
    mut keep_path := regex.regex_opt(r"\?.*$") !

    return keep_path.replace(path, "")
}

fn parse_method(method string) Method {
    return match method.to_lower() {
        "post" {
            .post
        }

        "get" {
            .get
        }

        else {
            .get
        }
    }
}

fn parse_queries(path string) map[string]string {
    mut remove_non_query := regex.regex_opt(r"^.*\?") or {
        return {}
    }

    query := remove_non_query.replace(path, "")

    if query == path {
        return {}
    }

    parts := query.split("&")

    mut queries := map[string]string{}

    for part in parts {
        key_value := part.split("=")

        key := key_value[0] or { "" }
        value := key_value[1] or { "" }

        if key.len == 0 {
            continue
        }

        queries[key] = value
    }

    return queries
}

fn (app App) serve_in_standalone_mode()! {
    console.info("Serving requests with up to ${app.cpus} workers (standalone mode)")

    mut tcp_listener := net.listen_tcp(net.AddrFamily.ip, app.address())!

    mut processes := []thread{}

    for {
        if processes.len >= 8 {
            process := rand.element(processes) or {
                console.error(err.msg())

                continue
            }

            process.wait()
        }

        mut connection := tcp_listener.accept() or {
            console.error(err.msg())

            continue
        }

        processes << spawn handle_connection(mut connection, app)
    }
}

fn (app App) validate_options()! {
    validation_rules := {
        "port": [
            Rule(Min{1})
            Rule(Max{65535})
        ]
    }

    data := {
        "port": Value(app.port)
    }

    validation.validate(data, validation_rules)!
}

pub fn (app App) find_route() ?Route {
    for route in app.routes {
        if route.matches(app.request) {
            return route
        }
    }

    return none
}

pub fn (app App) render() Response {
    route := app.find_route() or {
        return app.handle_error(HttpError{
            code: .not_found
            message: 'Route not found'
        })
    }

    return route.callback(app)
}

/**
 * @todo Extract logic to a function "respond(http_lines []string) Response", so that we can test it with raw HTTP body. For example to check if body is correctly decoded.
 */
fn handle_connection(mut connection net.TcpConn, app App) {
    mut parse_watch := time.new_stopwatch()

    ip := connection.peer_ip() or {""}
    mut headers := map[string][]string{}
    mut lines := []string{}
    mut form := map[string]string{}

    for {
        line := connection.read_line().replace("\n", "").replace("\r", "")

        if line == "" {
            break
        }

        lines << line
    }

    // Parse data
    request_line := lines[0] or { "" }
    request_line_parts := request_line.split(" ")
    method := request_line_parts[0] or { "GET" }
    path := request_line_parts[1] or { "" }
    version := request_line_parts[2] or { "HTTP/1.1" }

    if path == "" {
        console.error("Could not get path from request.")

        connection.write_string("${version} ${Status.server_error.to_int()} ${Status.server_error.to_string()}") or {
            console.error(err.msg())

            connection.close() or {
                console.error(err.msg())
            }
        }

        return
    }

    // Next are headers
    for i := 1; i < lines.len; i++ {
        line := lines[i]
        parts := line.split(":")

        if parts.len < 2 {
            continue
        }

        key := parts[0].trim_space()
        value := parts[1..].join(":").trim_space()

        if key in headers {
            headers[key] << value
        } else {
            headers[key] = [value]
        }
    }

    // Handle body if it's a POST request
    if method.to_upper() == "POST" {
        content_length := headers["Content-Length"] or { ["0"] }
        length := content_length[0].int()

        if length > 0 {
            content_type := headers["Content-Type"] or { [""] }

            if content_type[0].starts_with("application/x-www-form-urlencoded") {
                mut body := []u8{len: length}
                connection.read(mut body) or {
                    console.error("Failed to read request body: ${err}")
                    return
                }

                body_str := body.bytestr()
                form = parse_form_urlencoded(body_str)
            }
        }
    }

    req := create_request(
        method: method
        path: path
        ip: ip
        http_version: version
    )

    session := Session{
        ...app.session
        id: req.cookies.get("session_id") or { "" }
    }

    app_with_request := App{
        ...app,
        session: session
        request: req
    }

    parse_watch.stop()

    mut response_watch := time.new_stopwatch()

    response := app_with_request.render()

    response_watch.stop()

    connection.write_string("${req.http_version} ${response.status.to_int()} ${response.status.to_string()}\n${response.raw_headers()}\n${response.content}") or {
        console.error(err.msg())

        connection.close() or {
            console.error(err.msg())
        }
    }

    connection.close() or {
        console.error(err.msg())
    }

    console.info("[${response.status.to_int()}] ${req.ip} ${req.method.to_string()} ${req.http_version} ${path} (resp: ${response_watch.elapsed()}, parse: ${parse_watch.elapsed()})")
}

fn parse_form_urlencoded(body string) map[string]string {
    mut form := map[string]string{}
    parts := body.split("&")

    for part in parts {
        key_value := part.split("=")
        if key_value.len != 2 {
            continue
        }

        key := decode_url(key_value[0])
        value := decode_url(key_value[1])
        form[key] = value
    }

    return form
}
