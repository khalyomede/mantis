module html

pub fn i(attributes map[string]AttributeValue, children []string) string {
    return anon("i", attributes, children, false)
}
