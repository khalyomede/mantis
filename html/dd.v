module html

pub fn dd(attributes map[string]AttributeValue, children []string) string {
    return anon("dd", attributes, children, false)
}
