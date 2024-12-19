module html

pub fn h2(attributes map[string]AttributeValue, children []string) string {
    return anon("h2", attributes, children, false)
}
