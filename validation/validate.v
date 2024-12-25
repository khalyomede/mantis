module validation

struct Validator {
mut:
    rules map[string]Rule
}

pub fn Validator.new() Validator {
    return Validator{
        rules: {
            "min": Rule(Min{}),
            "max": Rule(Max{}),
            // "required": Rule(RequiredRule{}),
        }
    }
}

pub fn (mut v Validator) add_rule(name string, rule Rule) {
    v.rules[name] = rule
}

fn (v Validator) apply_rule(name string, val Value, rule string) ! {
    rules := rule.split(',')
    for r in rules {
        opts := r.split(':')

        validation_rule := v.rules[opts[0]] or { continue }
        if !validation_rule.validate(val, opts[1..]) {
            return error(validation_rule.message(val, name, opts[1..]))
        }
    }
}

pub fn (v Validator) validate[T](data map[string]Value) !T {
    mut validated := T{}

    $for field in T.fields {
        attrs := field.attrs

        for attr in attrs {
            opts := attr.split(': ')
            if opts[0] == 'validate' {
                // FIX: provide default instead of erroring. `data[field.name]`
                v.apply_rule(field.name, data[field.name]!, opts[1]) or {
                    return err
                }
            }
        }

        // update all fields
        field_val := data[field.name] or { "" }
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
