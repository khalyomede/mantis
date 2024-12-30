module html

pub fn thead(attributes map[string]AttributeValue, children []string) string {
    return anon("thead", attributes, children, false)
}
