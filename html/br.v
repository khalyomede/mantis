module html

pub fn br(attributes map[string]AttributeValue) string {
    return anon("br", attributes, [], true)
}
