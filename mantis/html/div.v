module html

pub fn div(attributes map[string]AttributeValue, children []string) string {
    return anon("div", attributes, children, false)
}
