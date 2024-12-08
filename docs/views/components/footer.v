module components

import mantis.html { div, h3, a, footer }

pub fn footer_page() string {
    return footer({"class": "bg-body-tertiary"}, [
        div({"class": "container p-3"}, [
            div({"class": "row"}, [
                div({"class": "col col-3"}, [
                    h3({}, ["Learn"]),
                    a({"href": "#", "class": "d-block"}, ["Getting started"]),
                    a({"href": "#", "class": "d-block"}, ["Documentation"]),
                ])
            ])
        ])
    ])
}
