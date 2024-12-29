module html

pub fn legend(attributes map[string]AttributeValue, children []string) string {
    return anon("legend", attributes, children, false)
}
