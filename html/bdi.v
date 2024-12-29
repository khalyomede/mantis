module html

pub fn bdi(attributes map[string]AttributeValue, children []string) string {
    return anon("bdi", attributes, children, false)
}
