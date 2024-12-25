module validation

pub struct Max {}

pub fn (rule Max) validate(val Value, opts []string) bool {
    cmp := opts[0].int()
    return match val {
        string { val.trim(' ').len < cmp }
        int { val < cmp }
        u16 { val < cmp }
    }
}

pub fn (rule Max) message(value Value, key string, opts []string) string {
    return "The ${key} must be lower than ${opts[0]}."
}
