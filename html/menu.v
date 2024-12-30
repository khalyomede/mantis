module html

pub fn menu(attributes map[string]AttributeValue, children []string) string {
    return anon("menu", attributes, children, false)
}
