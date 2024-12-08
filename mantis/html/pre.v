module html

pub fn pre(attributes map[string]AttributeValue, children []string) string {
    return anon("pre", attributes, children, false)
}
