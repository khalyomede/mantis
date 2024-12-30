module html

pub fn time(attributes map[string]AttributeValue, children []string) string {
    return anon("time", attributes, children, false)
}
