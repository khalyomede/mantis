module html

pub fn tfoot(attributes map[string]AttributeValue, children []string) string {
    return anon("tfoot", attributes, children, false)
}
