module html

pub fn source(attributes map[string]AttributeValue, children []string) string {
    return anon("source", attributes, children, true)
}
