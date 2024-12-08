module html

pub fn hr(attributes map[string]AttributeValue) string {
    return anon("hr", attributes, [], true)
}
