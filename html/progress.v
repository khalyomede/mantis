module html

pub fn progress(attributes map[string]AttributeValue, children []string) string {
    return anon("progress", attributes, children, false)
}
