module html

pub fn dfn(attributes map[string]AttributeValue, children []string) string {
    return anon("dfn", attributes, children, false)
}
