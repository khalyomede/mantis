module html

pub fn h3(attributes map[string]AttributeValue, children []string) string {
    return anon("h3", attributes, children, false)
}
