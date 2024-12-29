module html

pub fn colgroup(attributes map[string]AttributeValue, children []string) string {
    return anon("colgroup", attributes, children, false)
}
