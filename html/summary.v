module html

pub fn summary(attributes map[string]AttributeValue, children []string) string {
    return anon("summary", attributes, children, false)
}
