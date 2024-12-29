module html

pub fn samp(attributes map[string]AttributeValue, children []string) string {
    return anon("samp", attributes, children, false)
}
