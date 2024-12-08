module html

pub fn li(attributes map[string]AttributeValue, children []string) string {
    return anon("li", attributes, children, false)
}
