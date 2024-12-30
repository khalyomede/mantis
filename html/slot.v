module html

pub fn slot(attributes map[string]AttributeValue, children []string) string {
    return anon("slot", attributes, children, false)
}
