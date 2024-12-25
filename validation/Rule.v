module validation

pub interface Rule {
    validate(value Value, opts []string) bool
    message(value Value, key string, opts []string) string
}
