module html

pub fn output(attributes map[string]AttributeValue, children []string) string {
    return anon("output", attributes, children, false)
}
