module console

pub struct Command {
    pub:
        name string
        description string
        signature []Part
        examples []Example
        callback fn (mut App) Response @[required]
}

// Move it to a dedicated Command{} property instead?
pub fn (command Command) console_name() ?string {
    for part in command.signature {
        match part {
            Name {
                return part.name
            }
            else {
                continue
            }
        }
    }

    return none
}

pub fn (command Command) arguments() []Argument {
    mut arguments := []Argument{}

    for part in command.signature {
        match part {
            Argument {
                arguments << part as Argument
            }
            else {
                continue
            }
        }
    }

    return arguments
}

pub fn (command Command) flags() []Flag {
    mut flags := []Flag{}

    for part in command.signature {
        match part {
            Flag {
                flags << part as Flag
            }
            else {
                continue
            }
        }
    }

    return flags
}

pub fn (command Command) options() []Opt {
    mut options := []Opt{}

    for part in command.signature {
        match part {
            Opt {
                options << part as Opt
            }
            else {
                continue
            }
        }
    }

    return options
}

fn (command Command) name() ?string {
    for part in command.signature {
        match part {
            Name {
                return part.name
            }
            else {
                continue
            }
        }
    }

    return none
}
