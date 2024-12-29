module html

pub fn label(attributes map[string]AttributeValue, children []string) string {
    return anon("label", attributes, children, false)
}
