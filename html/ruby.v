module html

pub fn ruby(attributes map[string]AttributeValue, children []string) string {
    return anon("ruby", attributes, children, false)
}
