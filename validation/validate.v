module validation

pub fn validate(data map[string]Value, rules map[string][]Rule) !map[string]Value {
    mut validated := map[string]Value{}

    for key, rule_list in rules {
        value := data[key]!

        for rule in rule_list {
            if !rule.validate(value) {
                return ValidationError{
                    key: key,
                    value: value,
                    rule: rule
                }
            }
        }

        validated[key] = value
    }

    return validated
}
