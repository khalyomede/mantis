module html

pub fn html(attributes map[string]AttributeValue, children []string) string {
    return anon("html", attributes, children, false)
}
