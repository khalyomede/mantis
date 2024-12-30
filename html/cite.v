module html

pub fn cite(attributes map[string]AttributeValue, children []string) string {
    return anon("cite", attributes, children, false)
}
