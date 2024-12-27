module validation

pub fn validate_struct[T](data map[string]Value, rules map[string][]Rule) !T {
    mut validated := T{}

    validated_data := validate(data, rules)!

    $for field in T.fields {
        field_val := validated_data[field.name] or {
            // NOTE: this can be fine in some cases.
            return error("${field.name} does not exist.")
        }

        $if field.typ is string {
            validated.$(field.name) = field_val as string
        } $else $if field.typ is int {
            validated.$(field.name) = field_val as int
        } $else $if field.typ is u16 {
            validated.$(field.name) = field_val as u16
        }
    }

    return validated
}

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
