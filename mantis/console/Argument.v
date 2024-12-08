module console

pub struct Argument {
    pub:
        name string
        description string

    value string
}

pub fn (arguments []Argument) get(key string) ?string {
    argument := arguments.filter(it.name == key)[0] or {
        return none
    }

    return argument.value
}
