module html

pub fn meter(attributes map[string]AttributeValue, children []string) string {
    return anon("meter", attributes, children, false)
}
