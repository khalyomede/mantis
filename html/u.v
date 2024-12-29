module html

pub fn u(attributes map[string]AttributeValue, children []string) string {
    return anon("u", attributes, children, false)
}
