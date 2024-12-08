module validation

pub struct Max {
    pub:
        value int
}

fn (rule Max) validate(value Value) bool {
    return match value {
        string {
            value.len < rule.value
        }

        int {
            value < rule.value
        }

        u16 {
            value < rule.value
        }
    }
}

pub fn (rule Max) message(key string) string {
    return "The ${key} must be lower than ${rule.value}."
}
