module html

pub fn header(attributes map[string]AttributeValue, children []string) string {
    return anon("header", attributes, children, false)
}
