module html

pub fn s(attributes map[string]AttributeValue, children []string) string {
    return anon("s", attributes, children, false)
}
