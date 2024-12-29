module html

pub fn param(attributes map[string]AttributeValue, children []string) string {
    return anon("param", attributes, children, true)
}
