module html

pub fn iframe(attributes map[string]AttributeValue, children []string) string {
    return anon("iframe", attributes, children, false)
}
