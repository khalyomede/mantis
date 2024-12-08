module html

pub fn p(attributes map[string]AttributeValue, children []string) string {
    return anon("p", attributes, children, false)
}
