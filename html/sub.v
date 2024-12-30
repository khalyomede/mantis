module html

pub fn sub(attributes map[string]AttributeValue, children []string) string {
    return anon("sub", attributes, children, false)
}
