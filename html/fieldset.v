module html

pub fn fieldset(attributes map[string]AttributeValue, children []string) string {
    return anon("fieldset", attributes, children, false)
}
