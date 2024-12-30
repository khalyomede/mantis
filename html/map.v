module html

pub fn map(attributes map[string]AttributeValue, children []string) string {
    return anon("map", attributes, children, false)
}
