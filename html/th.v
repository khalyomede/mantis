module html

pub fn th(attributes map[string]AttributeValue, children []string) string {
    return anon("th", attributes, children, false)
}
