module html

pub fn rtc(attributes map[string]AttributeValue, children []string) string {
    return anon("rtc", attributes, children, false)
}
