module components

import mantis.html { div }

pub fn accordion(id string, items []string) string {
    return div({"class": "accordion accordion-flush", "id": id}, items)
}
