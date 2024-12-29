module html

pub fn object(attributes map[string]AttributeValue, children []string) string {
    return anon("object", attributes, children, false)
}
