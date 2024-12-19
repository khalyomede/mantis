module html

pub fn code(attributes map[string]AttributeValue, children []string) string {
    return anon("code", attributes, children, false)
}
