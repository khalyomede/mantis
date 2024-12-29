module html

pub fn embed(attributes map[string]AttributeValue, children []string) string {
    return anon("embed", attributes, children, true)
}
