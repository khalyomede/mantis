module html

pub fn b(attributes map[string]AttributeValue, children []string) string {
    return anon("b", attributes, children, false)
}
