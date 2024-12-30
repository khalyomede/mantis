module html

pub fn rt(attributes map[string]AttributeValue, children []string) string {
    return anon("rt", attributes, children, false)
}
