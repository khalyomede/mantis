module html

pub fn details(attributes map[string]AttributeValue, children []string) string {
    return anon("details", attributes, children, false)
}
