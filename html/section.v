module html

pub fn section(attributes map[string]AttributeValue, children []string) string {
    return anon("section", attributes, children, false)
}
