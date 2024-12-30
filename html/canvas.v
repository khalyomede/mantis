module html

pub fn canvas(attributes map[string]AttributeValue, children []string) string {
    return anon("canvas", attributes, children, false)
}
