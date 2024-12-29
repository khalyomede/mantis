module html

pub fn portal(attributes map[string]AttributeValue, children []string) string {
    return anon("portal", attributes, children, false)
}
