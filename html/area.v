module html

pub fn area(attributes map[string]AttributeValue, children []string) string {
    return anon("area", attributes, children, true)
}
