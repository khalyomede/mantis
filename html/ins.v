module html

pub fn ins(attributes map[string]AttributeValue, children []string) string {
    return anon("ins", attributes, children, false)
}
