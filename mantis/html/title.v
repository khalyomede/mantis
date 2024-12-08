module html

pub fn title(attributes map[string]AttributeValue, children []string) string {
    return anon("title", attributes, children, false)
}
