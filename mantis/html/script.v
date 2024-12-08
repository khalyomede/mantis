module html

pub fn script(attributes map[string]AttributeValue, children []string) string {
    return anon("script", attributes, children, false)
}
