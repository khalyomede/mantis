module html

pub fn base(attributes map[string]AttributeValue, children []string) string {
    return anon("base", attributes, children, true)
}
