module html

pub fn main(attributes map[string]AttributeValue, children []string) string {
    return anon("main", attributes, children, false)
}
