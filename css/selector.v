module css

type PropertyValue = string|int

pub fn selector(name string, properties map[string]PropertyValue) string {
    mut content := "${name} {"

    for key, value in properties {
        data := match value {
            string {
                value
            }

            int {
                value.str()
            }
        }

        content = "${content}\n    ${key}: ${data};"
    }

    return "${content}\n}"
}
