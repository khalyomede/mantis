module html

pub fn h4(attributes map[string]AttributeValue, children []string) string {
    return anon("h4", attributes, children, false)
}
