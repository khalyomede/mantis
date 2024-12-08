module components

import mantis.html { div, h2, a }

pub fn title(hash string, content []string) string {
    mut data := []string{}

    data << a({"class": "me-2 text-secondary text-decoration-none", "href": "#${hash}"}, ["#"])

    for item in content {
        data << item
    }

    return div({"class": "mb-3 mt-5"}, [
        h2({"class": ""}, data)
    ])
}
