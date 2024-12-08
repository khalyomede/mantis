module html

pub fn span(attributes map[string]AttributeValue, children []string) string {
    return anon("span", attributes, children, false)
}
