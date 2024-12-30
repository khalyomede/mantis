module html

pub fn form(attributes map[string]AttributeValue, children []string) string {
    return anon("form", attributes, children, false)
}
