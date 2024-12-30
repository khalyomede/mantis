module html

pub fn var(attributes map[string]AttributeValue, children []string) string {
    return anon("var", attributes, children, false)
}
