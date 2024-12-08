module html

pub fn body(attributes map[string]AttributeValue, children []string) string {
    return anon("body", attributes, children, false)
}
