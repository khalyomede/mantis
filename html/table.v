module html

pub fn table(attributes map[string]AttributeValue, children []string) string {
    return anon("table", attributes, children, false)
}
