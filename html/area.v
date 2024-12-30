module html

pub fn area(attributes map[string]AttributeValue) string {
    return anon("area", attributes, [], true)
}
