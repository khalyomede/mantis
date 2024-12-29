module html

pub fn aside(attributes map[string]AttributeValue, children []string) string {
    return anon("aside", attributes, children, false)
}
