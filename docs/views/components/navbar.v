module components

import mantis.html { nav, div, a, span, button, header }

pub fn navbar(brand string, home_url string, menus map[string]string) string {
    return header({"class": "navbar bg-body-tertiary sticky-top"}, [
        nav({"class": "container"}, [
            a({"class": "navbar-brand", "href": home_url}, [brand])
            button({"class": "btn btn-secondary btn-sm", "id": "toggle-sidebar", "data-bs-toggle": "offcanvas", "href": "#sidebar", "role": "button", "aria-controls": "sidebar"}, [
                "menu"
            ]),
            sidebar("Mantis", menus),
        ])
    ])
}
