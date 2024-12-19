module html

pub fn button(attributes map[string]AttributeValue, children []string) string {
    return anon("button", attributes, children, false)
}
