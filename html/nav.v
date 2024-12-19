module html

pub fn nav(attributes map[string]AttributeValue, children []string) string {
    return anon("nav", attributes, children, false)
}
