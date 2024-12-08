module controllers

import mantis { App, Response }
import mantis.html { div, h1, a, }
import views.layouts { layout }
import views.components { alert, title, text, accordion, accordion_item }

pub fn documentation_index(app App) Response {
    return Response{
        content: layout(app, [
            div({"class": "row"}, [
                div({"class": "col col-6 offset-3"}, [
                    div({"class": "row"}, [
                        div({"class": "col col-12"}, [
                            h1({}, ["Documentation"])
                            div({"class": "mt-3 mb-5"}, [
                                alert(.primary, [
                                    "We recommend you start by reading the "
                                    a({"href": app.route("getting-started.index", {}) or { "#" }}, ["Getting Started"])
                                    " section in order to ease your understanding."
                                ])
                            ]),
                            title("prerequisites", ["Prerequisites"])
                            text(["Before diving into the documentation, we recommend you have some knowledge in the concepts below."])
                            accordion("prerequisites", [
                                accordion_item("prerequisites", "v", ["V"], ["Mantis uses V as the primary language for developping the back-end."])
                                accordion_item("prerequisites", "docker-compose", ["Docker Compose"], ["Docker Compose is used to start the local environment."])
                            ])
                            title("introduction", ["Introduction"])
                            text(["Mantis is a web framework for building server-side web apps and APIs."])
                            text(["It uses V as programming language for its simplicity reliability and type safety."])
                        ])
                    ])
                ])
            ])
        ])
    }
}
