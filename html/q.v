module html

pub fn q(attributes map[string]AttributeValue, children []string) string {
    return anon("q", attributes, children, false)
}
