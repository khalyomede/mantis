module html

pub fn data(attributes map[string]AttributeValue, children []string) string {
    return anon("data", attributes, children, false)
}
