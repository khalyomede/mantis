module html

pub fn optgroup(attributes map[string]AttributeValue, children []string) string {
    return anon("optgroup", attributes, children, false)
}
