module components

import mantis.html { div, h5, button, a, ul, li, hr, each }

pub fn sidebar(brand string, menus map[string]string) string {
    return div({ "class": "offcanvas offcanvas-end", "tabindex": "-1", "id": "sidebar", "aria-labelledby": "sidebarLabel" }, [
        div({ "class": "offcanvas-header" }, [
            h5({ "class": "offcanvas-title", "id": "sidebarLabel" }, [
                brand
            ]),
            button({ "type": "button", "class": "btn-close", "data-bs-dismiss": "offcanvas", "aria-label": "Close" }, [])
        ]),
        div({ "class": "offcanvas-body" }, [
            ul({ "class": "navbar-nav justify-content-end flex-grow-1 pe-3" }, [
                each(menus, fn (text string, link string) string {
                    return li({ "class": "nav-item" }, [
                        a({ "class": "nav-link active", "aria-current": "page", "href": link }, [
                            text
                        ])
                    ])
                })
            ])
        ])
    ])
}
