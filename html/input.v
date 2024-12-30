module html

pub fn input(attributes map[string]AttributeValue) string {
    return anon("input", attributes, [], true)
}
