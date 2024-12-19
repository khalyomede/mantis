module html

pub fn a(attributes map[string]AttributeValue, children []string) string {
    return anon("a", attributes, children, false)
}
