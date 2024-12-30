module html

pub fn datalist(attributes map[string]AttributeValue, children []string) string {
    return anon("datalist", attributes, children, false)
}
