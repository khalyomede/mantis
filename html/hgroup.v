module html

pub fn hgroup(attributes map[string]AttributeValue, children []string) string {
    return anon("hgroup", attributes, children, false)
}
