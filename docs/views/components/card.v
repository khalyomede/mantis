module components

import mantis.html { div, h2, p, a }

pub fn card(title string, content string) string {
    return div({"class": "card"}, [
        div({"class": "card-body"}, [
            h2({"class": "card-title fs-5"}, [title])
            p({"class": "card-text text-secondary"}, [content])
        ])
    ])
}
