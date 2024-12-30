module html

pub fn rb(attributes map[string]AttributeValue, children []string) string {
    return anon("rb", attributes, children, false)
}
