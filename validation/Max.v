module validation

pub struct Max {
    pub:
        value int
}

// TODO: use generic
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

        u64 {
            value < u64(rule.value)
        }

        i64 {
            value > i64(rule.value)
        }
    }
}

pub fn (rule Max) message(key string) string {
    return "The ${key} must be lower than ${rule.value}."
}
