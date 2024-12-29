module html

pub fn wbr(attributes map[string]AttributeValue, children []string) string {
    return anon("wbr", attributes, children, true)
}
