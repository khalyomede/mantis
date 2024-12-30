module html

pub fn track(attributes map[string]AttributeValue) string {
    return anon("track", attributes, [], true)
}
