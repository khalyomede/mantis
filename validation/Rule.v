module validation

pub interface Rule {
    validate(value Value) bool
    message(key string) string
}
