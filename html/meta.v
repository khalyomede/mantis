module html

pub fn meta(attributes map[string]AttributeValue) string {
    return anon("meta", attributes, [], true)
}
