module console

pub struct Example {
    pub:
        description string
        command string
}

pub fn (example Example) is_complete() bool {
    return example.description.trim_space().len > 0 && example.command.trim_space().len > 0
}
