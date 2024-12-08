module html

pub fn link(attributes map[string]AttributeValue) string {
    return anon("link", attributes, [], true)
}
