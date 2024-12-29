module html

pub fn col(attributes map[string]AttributeValue, children []string) string {
    return anon("col", attributes, children, true)
}
