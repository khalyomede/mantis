module validation

pub struct Min {}

pub fn (rule Min) validate(val Value, opts []string) bool {
    cmp := opts[0].int()
    return match val {
        string { val.trim(' ').len > cmp }
        int { val > cmp }
        u16 { val > cmp }
    }
}

pub fn (rule Min) message(value Value, key string, opts []string) string {
    return "The ${key} must be greater than ${opts[0]}."
}
