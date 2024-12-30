module html

pub fn base(attributes map[string]AttributeValue) string {
    return anon("base", attributes, [], true)
}
