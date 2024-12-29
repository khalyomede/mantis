module html

pub fn del(attributes map[string]AttributeValue, children []string) string {
    return anon("del", attributes, children, false)
}
