module html

pub fn sup(attributes map[string]AttributeValue, children []string) string {
    return anon("sup", attributes, children, false)
}
