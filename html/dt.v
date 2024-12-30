module html

pub fn dt(attributes map[string]AttributeValue, children []string) string {
    return anon("dt", attributes, children, false)
}
