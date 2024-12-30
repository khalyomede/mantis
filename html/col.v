module html

pub fn col(attributes map[string]AttributeValue) string {
    return anon("col", attributes, [], true)
}
