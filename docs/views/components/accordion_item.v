module components

import mantis.html { div, button }

pub fn accordion_item(parent_id string, id string, title []string, body []string) string {
    return div({"class": "accordion-item"}, [
        div({"class": "accordion-header"}, [
            button({"class": "accordion-button collapsed", "type": "button", "data-bs-toggle": "collapse", "data-bs-target": "#flush-${id}", "aria-expanded": "false", "aria-controls": "flush-${id}"}, title)
        ])
        div({"id": "flush-${id}", "class": "accordion-collapse collapse", "data-bs-parent": "#${parent_id}"}, [
            div({"class": "accordion-body"}, body)
        ])
    ])
}
