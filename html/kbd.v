module html

pub fn kbd(attributes map[string]AttributeValue, children []string) string {
    return anon("kbd", attributes, children, false)
}
