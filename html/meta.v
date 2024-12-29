module html

pub fn meta(attributes map[string]AttributeValue, children []string) string {
    return anon("meta", attributes, children, false)
}
