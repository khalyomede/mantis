module html

pub fn footer(attributes map[string]AttributeValue, children []string) string {
    return anon("footer", attributes, children, false)
}
