module html

pub fn article(attributes map[string]AttributeValue, children []string) string {
    return anon("article", attributes, children, false)
}
