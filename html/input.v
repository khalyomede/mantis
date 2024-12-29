module html

pub fn input(attributes map[string]AttributeValue, children []string) string {
    return anon("input", attributes, children, true)
}
