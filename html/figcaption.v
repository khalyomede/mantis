module html

pub fn figcaption(attributes map[string]AttributeValue, children []string) string {
    return anon("figcaption", attributes, children, false)
}
