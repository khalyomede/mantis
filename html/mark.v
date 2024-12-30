module html

pub fn mark(attributes map[string]AttributeValue, children []string) string {
    return anon("mark", attributes, children, false)
}
