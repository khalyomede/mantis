module html

pub fn head(attributes map[string]AttributeValue, children []string) string {
    return anon("head", attributes, children, false)
}
