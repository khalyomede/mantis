module html

pub fn template(attributes map[string]AttributeValue, children []string) string {
    return anon("template", attributes, children, false)
}
