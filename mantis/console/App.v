module console

pub struct App {
    pub:
        commands []Command
        arguments []Argument
        flags []Flag
        options []Opt

    console_signature []ConsolePart

    mut:
        output []string
        current_command Command = Command{ callback: fn (mut app App) Response { return app.exit(1) }}
}

pub fn (app App) render() ?Response {
    command := app.find_command() ? // List all commands instead

    // 1. Here check at compile time that no arguments has reserved names "_program" or "_command".
    // 2. Instead of app.arguments[2..], remove them by name using a .filter()

    mut scoped_app := App{
        ...app
        arguments: app.extract_arguments()
        flags: app.extract_flags()
        options: app.extract_options()
        current_command: command
    }

    return command.callback(mut scoped_app)
}

pub fn (mut app App) info(message string) {
    app.output << message

    info(message)
}

pub fn (app App) exit(code int) Response {
    return Response{
        output: app.output.join("\n")
        code: code
    }
}

pub fn (app App) has_flag(key string) bool {
    for flag in app.flags {
        if flag.long == key || flag.short == key {
            return true
        }
    }

    return false
}

pub fn (app App) help_text() string {
    mut lines := []string{}
    mut signature := []string{}
    command := app.current_command
    name := command.console_name() or { "" }
    arguments := command.arguments()
    options := command.options()
    flags := command.flags()
    examples := command.examples

    // Description
    if command.description.trim_space().len > 0 {
        lines << command.description
    }

    // Signature
    if arguments.len > 0 || flags.len > 0 || options.len > 0 {
        lines << ""
        lines << "Usage:"
        lines << ""

        for argument in arguments {
            signature << "${name} [${argument.name}]"
        }

        if options.len > 0 {
            signature << "[...options]"
        }

        if flags.len > 0 {
            signature << "[...flags]"
        }

        signature_text := signature.join(" ")

        lines << "  ${signature_text}"
    }

    // Arguments
    if arguments.len > 0 {
        lines << ""
        lines << "Arguments:"
        lines << ""

        for argument in arguments {
            lines << "  ${argument.name}: ${argument.description}"
        }
    }

    // Options
    if options.len > 0 {
        lines << ""
        lines << "Options:"
        lines << ""

        // Make sure at compile time all Opt have at least a short or long variant.
        // Same for flags.

        for option in options {
            mut line := if option.has_all_variants() {
                "--${option.long}, -${option.short}"
            } else if option.has_long_variant() {
                "--${option.long}"
            } else if option.has_short_variant() {
                "-${option.short}"
            } else {
                ""
            }

            if line.trim_space().len == 0 {
                continue
            }

            if option.has_description() {
                line = line + ": ${option.description}"
            }

            lines << "  ${line}"
        }
    }

    // Flags
    if flags.len > 0 {
        lines << ""
        lines << "Flags:"
        lines << ""

        for flag in flags {
            mut line := if flag.has_all_variants() {
                "--${flag.long}, -${flag.short}"
            } else if flag.has_long_variant() {
                "--${flag.long}"
            } else if flag.has_short_variant() {
                "-${flag.short}"
            } else {
                ""
            }

            if line.trim_space().len == 0 {
                continue
            }

            if flag.has_description() {
                line = line + ": ${flag.description}"
            }

            lines << "  ${line}"
        }
    }

    // Examples
    if examples.len > 0 {
        lines << ""
        lines << "Examples:"

        for example in examples {
            if !example.is_complete() {
                continue
            }

            lines << ""
            lines << "  ${example.description}"
            lines << "    ${example.command}"
        }
    }

    return lines.join("\n")
}

fn (app App) find_command() ?Command {
    name := app.get_console_command_name() ?

    command := app.commands.filter(it.name() or { "" } == name)[0] or {
        return none
    }

    return command
}

fn (app App) get_console_command_name() ?string {
    for part in app.console_signature {
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

fn (app App) extract_arguments() []Argument {
    mut arguments := []Argument{}

    for part in app.console_signature {
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

fn (app App) extract_flags() []Flag {
    mut flags := []Flag{}

    for part in app.console_signature {
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

fn (app App) extract_options() []Opt {
    mut options := []Opt{}

    for part in app.console_signature {
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
