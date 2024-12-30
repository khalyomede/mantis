module html

pub fn search(attributes map[string]AttributeValue, children []string) string {
    return anon("search", attributes, children, false)
}
