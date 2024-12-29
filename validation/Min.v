module validation

pub struct Min {
    pub:
        value int
}

// TODO: use generic
pub fn (rule Min) validate(value Value) bool {
    return match value {
        string {
            value.len > rule.value
        }

        int {
            value > rule.value
        }

        u16 {
            value > rule.value
        }

        u64 {
            value > u64(rule.value)
        }

        i64 {
            value > i64(rule.value)
        }
    }
}

pub fn (rule Min) message(key string) string {
    return "The ${key} must be greater than ${rule.value}."
}
