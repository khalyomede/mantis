module html

pub fn wbr(attributes map[string]AttributeValue) string {
    return anon("wbr", attributes, [], true)
}
