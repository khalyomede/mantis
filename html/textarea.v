module html

pub fn textarea(attributes map[string]AttributeValue, children []string) string {
    return anon("textarea", attributes, children, false)
}
