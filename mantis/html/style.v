module html

pub fn style(attributes map[string]AttributeValue, children []string) string {
    return anon("style", attributes, children, false)
}
