module html

pub fn abbr(attributes map[string]AttributeValue, children []string) string {
    return anon("abbr", attributes, children, false)
}
