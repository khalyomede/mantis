module html

pub fn param(attributes map[string]AttributeValue) string {
    return anon("param", attributes, [], true)
}
