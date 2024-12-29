module html

pub fn dialog(attributes map[string]AttributeValue, children []string) string {
    return anon("dialog", attributes, children, false)
}
