module validation

pub struct ValidationError {
    pub:
        key string
        value Value
        rule Rule
}

pub fn (error ValidationError) msg() string {
    return error.rule.message(error.value, error.key, []string{})
}

pub fn (error ValidationError) code() int {
    return 1
}
