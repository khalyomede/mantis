module html

pub fn tbody(attributes map[string]AttributeValue, children []string) string {
    return anon("tbody", attributes, children, false)
}
