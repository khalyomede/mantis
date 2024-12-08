module controllers

import views.components { navbar, sidebar, card, footer_page }
import mantis { App, Response }
import mantis.html { h1, div, small, p, button, pre, code, span, p, h2 }
import views.layouts { layout }

pub fn index(app App) Response {
    return Response{
        content: layout(app, [
            div({"class": "row"}, [
                div({"class": "col col-6 d-flex flex-column justify-content-center"}, [
                    h1({}, [
                        span({}, ["Mantis"]),
                        div({"class": "mt-1"}, [
                            small({"class": "fs-4"}, ["Reliable, type-safe no magic web framework"])
                        ])
                    ]),
                    p({"class": "text-secondary"}, ["For people that like to sleep at night. Written in V."]),
                    div({"class": "mt-3"}, [
                        button({"class": "btn btn-primary me-2"}, ["Getting started"])
                        button({"class": "btn btn-secondary"}, ["Documentation"])
                    ])
                ])
                div({"class": "col col-6"}, [
                    pre({"class": "rounded"}, [
                        code({"class": "language-go"}, [
                            "import mantis { App, Response }\n",
                            "\n",
                            "fn main() {\n"
                            "  app := App{\n",
                            "    routes: [\n"
                            "      Route{ \"index\", \"/\", .get, fn (app App) Response {\n"
                            "         return Response{\"Hello world\"}\n"
                            "       }\n"
                            "     ]\n"
                            "  }\n"
                            "\n"
                            "  app.serve() or { panic(err) }\n"
                            "}"
                        ])
                    ])
                ])
            ])
            div({"class": "row mt-5"}, [
                div({"class": "col col-4 mb-4"}, [
                    card("No uncatched errors", "If your app compiles, it will not throw runtime errors nor exceptions.")
                ])
                div({"class": "col col-4 mb-4"}, [
                    card("Easy deploy", "Mantis compiles a single executable containing your whole app, views, dot files, ...")
                ])
                div({"class": "col col-4 mb-4"}, [
                    card("Type safe", "Views, SQL, CSS are all type-safe to catch errors before deployment.")
                ])
            ])
            div({"class": "row mt-5"}, [
                div({"class": "col col-5"}, [
                    pre({"class": "rounded"}, [
                        code({"class": "language-go"}, [
                            "module controllers\n",
                            "\n"
                            "import mantis { App, Response }\n",
                            "import mantis.html { html, head, title body, h1 }\n",
                            "\n"
                            "pub fn index(app App) Response {\n",
                            "  return Response{\n",
                            '    content: html({"lang": "en"}, [\n',
                            "      head({}, [\n",
                            '        title({}, ["Book library - Booked"])\n',
                            "      ]),\n",
                            "      body({}, [\n",
                            '        h1({}, ["Welcome to the library"])\n',
                            "      ])\n",
                            "    ])\n",
                            "  }\n",
                            "}\n",
                        ])
                    ])
                ])
                div({"class": "col col-7 text-end d-flex justify-content-center flex-column"}, [
                    h2({"class": "fs-2"}, ["Typed views"]),
                    p({"class": "text-secondary fs-4"}, ["Use a powerful function based view templating system that help you catch errors. Supports layouts components & pages."])
                ])
            ])
            div({"class": "row mt-5"}, [
                div({"class": "col col-6 d-flex flex-column justify-content-center"}, [
                    h2({"class": "fs-2"}, ["Efficient & performant"])
                    p({"class": "text-secondary fs-4"}, ["Mantis uses as many cores as you tell it. Can serve up to 1000 req/s with 10 ms latency for static API or pages."])
                ])
                div({"class": "col col-6"}, [
                    pre({"class": "rounded"}, [
                        code({"class": "language-bash"}, [
                            "[INFO] listening on 0.0.0.0:80\n",
                            "[INFO] Serving requests with up to 8 workers (standalone mode)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (13.075ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (6.631ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (7.737ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (6.746ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (7.071ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (7.386ms)\n",
                            "[INFO] [200] 172.20.0.1 GET HTTP/1.1 / (6.307ms)\n",
                        ])
                    ])
                ])
            ]),
            div({"class": "row my-5"}, [
                div({"class": "col col-12"}, [
                    div({"class": "ml-embedded", "data-form": "H1t9WB"}, [])
                ])
            ])
        ])
        status: .ok
        headers: {
            "Content-Type": "text/html"
        }
    }
}
