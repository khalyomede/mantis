module html

pub fn em(attributes map[string]AttributeValue, children []string) string {
    return anon("em", attributes, children, false)
}
