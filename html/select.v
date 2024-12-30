module html

pub fn select(attributes map[string]AttributeValue, children []string) string {
    return anon("select", attributes, children, false)
}
