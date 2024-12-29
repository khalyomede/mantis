module html

pub fn picture(attributes map[string]AttributeValue, children []string) string {
    return anon("picture", attributes, children, false)
}
