module html

pub fn blockquote(attributes map[string]AttributeValue, children []string) string {
    return anon("blockquote", attributes, children, false)
}
