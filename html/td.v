module html

pub fn td(attributes map[string]AttributeValue, children []string) string {
    return anon("td", attributes, children, false)
}
