module html

pub fn rp(attributes map[string]AttributeValue, children []string) string {
    return anon("rp", attributes, children, false)
}
