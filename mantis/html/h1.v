module html

pub fn h1(attributes map[string]AttributeValue, children []string) string {
    return anon("h1", attributes, children, false)
}
