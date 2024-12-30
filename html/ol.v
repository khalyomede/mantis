module html

pub fn ol(attributes map[string]AttributeValue, children []string) string {
    return anon("ol", attributes, children, false)
}
