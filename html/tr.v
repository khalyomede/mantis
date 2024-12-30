module html

pub fn tr(attributes map[string]AttributeValue, children []string) string {
    return anon("tr", attributes, children, false)
}
