module html

pub fn img(attributes map[string]AttributeValue, children []string) string {
    return anon("img", attributes, children, true)
}
