module html

pub fn dl(attributes map[string]AttributeValue, children []string) string {
    return anon("dl", attributes, children, false)
}
