module html

pub fn svg(attributes map[string]AttributeValue, children []string) string {
    return anon("svg", attributes, children, false)
}
