module html

pub fn option(attributes map[string]AttributeValue, children []string) string {
    return anon("option", attributes, children, false)
}
