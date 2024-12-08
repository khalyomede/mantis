module components

import mantis.html { div }

pub fn alert(severity AlertSeverity, content []string) string {
    return div({"class": "alert alert-${severity.str()}"}, content)
}
