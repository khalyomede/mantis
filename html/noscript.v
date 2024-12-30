module html

pub fn noscript(attributes map[string]AttributeValue, children []string) string {
    return anon("noscript", attributes, children, false)
}
