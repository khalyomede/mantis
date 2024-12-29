module html

pub fn audio(attributes map[string]AttributeValue, children []string) string {
    return anon("audio", attributes, children, false)
}
