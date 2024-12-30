module html

pub fn source(attributes map[string]AttributeValue) string {
    return anon("source", attributes, [], true)
}
