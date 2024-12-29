module html

pub fn caption(attributes map[string]AttributeValue, children []string) string {
    return anon("caption", attributes, children, false)
}
