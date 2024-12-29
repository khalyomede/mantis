module html

pub fn strong(attributes map[string]AttributeValue, children []string) string {
    return anon("strong", attributes, children, false)
}
