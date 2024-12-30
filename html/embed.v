module html

pub fn embed(attributes map[string]AttributeValue) string {
    return anon("embed", attributes, [], true)
}
