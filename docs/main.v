module main

import mantis.http { create_app, Response, App }
import mantis.http.route
import mantis.http.response

fn main() {
    app := create_app(
        port: 80
        host: "0.0.0.0"
        mode: .standalone
        routes: [
            route.get(name: "index", path: "/", callback: fn (app App) Response {
                return response.html(content: "hello world")
            })
        ]
    )

    app.serve() or {
        panic(err)
    }
}
