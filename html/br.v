module html

pub fn br(attributes map[string]AttributeValue, children []string) string {
    return anon("br", attributes, children, false)
}
