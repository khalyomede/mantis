module html

pub fn bdo(attributes map[string]AttributeValue, children []string) string {
    return anon("bdo", attributes, children, false)
}
