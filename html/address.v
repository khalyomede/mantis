module html

pub fn address(attributes map[string]AttributeValue, children []string) string {
    return anon("abbr", attributes, children, false)
}
