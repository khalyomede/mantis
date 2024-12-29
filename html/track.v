module html

pub fn track(attributes map[string]AttributeValue, children []string) string {
    return anon("track", attributes, children, false)
}
