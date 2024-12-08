module html

pub fn h5(attributes map[string]AttributeValue, children []string) string {
    return anon("h5", attributes, children, false)
}
