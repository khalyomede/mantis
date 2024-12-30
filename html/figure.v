module html

pub fn figure(attributes map[string]AttributeValue, children []string) string {
    return anon("figure", attributes, children, false)
}
