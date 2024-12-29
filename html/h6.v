module html

pub fn h6(attributes map[string]AttributeValue, children []string) string {
    return anon("h6", attributes, children, false)
}
