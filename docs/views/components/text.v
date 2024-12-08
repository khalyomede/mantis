module components

import mantis.html { p }

pub fn text(content []string) string {
    return p({"class": ""}, content)
}
