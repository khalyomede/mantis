module html

pub fn img(attributes map[string]AttributeValue) string {
    return anon("img", attributes, [], true)
}
