module html

pub fn small(attributes map[string]AttributeValue, children []string) string {
    return anon("small", attributes, children, false)
}
