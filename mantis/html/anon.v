module html

pub fn anon(name string, attributes map[string]AttributeValue, children []string, orphan bool) string {
    mut html_content := "<" + name

    for key, data in attributes {
        value := match data {
            string {
                data
            }
            bool {
                match data {
                    true { "true" }
                    false { "false" }
                }
            }
        }

        html_content = "${html_content} ${key}=\"${value}\""
    }

    children_content := children.join("")

    if orphan {
        html_content = "${html_content} />"
    } else {
        html_content = "${html_content}>${children_content}</${name}>"
    }

    return html_content
}
