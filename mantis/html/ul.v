module html

pub fn ul(attributes map[string]AttributeValue, children []string) string {
    return anon("ul", attributes, children, false)
}
