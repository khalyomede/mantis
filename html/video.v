module html

pub fn video(attributes map[string]AttributeValue, children []string) string {
    return anon("video", attributes, children, false)
}
