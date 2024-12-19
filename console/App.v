module console

import os
import flag { new_flag_parser, FlagConfig }

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

    return app.render_command(command)
}

fn (app App) render_command(command Command) ?Response {
    mut scoped_app := App{
        ...app
        arguments: app.extract_arguments()
        flags: app.extract_flags()
        options: app.extract_options()
        current_command: command
    }

    return command.callback(mut scoped_app)
}

pub fn (app App) serve() {
    console_arguments := os.args

    /*
        TODO: display a list of all available commands instead.
    */
    signature := app.get_minimal_console_signature(console_arguments) or {
        eprintln(err.msg())

        exit(1)
    }

    partially_hydrated_app := App{
        ...app,
        console_signature: signature
    }

    /*
        TODO: display a list of all available commands instead.
    */
    command := partially_hydrated_app.find_command() or {
        eprintln(err.msg())

        exit(1)
    }

    hydrated_app := App{
        ...partially_hydrated_app,
        console_signature: app.get_complete_console_signature(console_arguments, command)
    }

    /*
        TODO: display a list of all available commands instead.
    */
  res := hydrated_app.render_command(command) or {
    eprintln(err.msg())
    exit(1)
  }

  exit(res.code)
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

/*
    TODO: Add some tests.

    This will get all the arguments from the console, and create their ConsolePart counterpart. For example, Console Part "Name" will be the first element. And so on...
*/
fn (app App) get_minimal_console_signature(arguments []string) ?[]ConsolePart {
    mut console_parts := []ConsolePart{}

    // First item is the program name
    program_name := arguments[0] or {
        return none
    }

    // Second item is the Mantis command name
    command_name := arguments[1] or {
        return none
    }

    console_parts << Program{program_name}
    console_parts << Name{command_name}

    return console_parts
}

fn (app App) get_complete_console_signature(arguments []string, command Command) []ConsolePart {
    mut console_parts := app.console_signature.clone()

    // Parsing all flags
    mut flag_parser := new_flag_parser(arguments)

    command_flags := command.signature.filter(it is Flag).map(it as Flag)

    for command_flag in command_flags {
        present := flag_parser.bool(command_flag.long, command_flag.short.u8(), false, "", FlagConfig{})

        if !present {
            continue
        }

        console_parts << command_flag
    }

    command_options := command.signature.filter(it is Opt).map(it as Opt)

    for command_option in command_options {
        value := flag_parser.string(command_option.long, command_option.short.u8(), "", "", FlagConfig{})
        value_is_empty := value.trim_space().len == 0

        if value_is_empty {
            continue
        }

        opt := Opt{
            ...command_option as Opt
            value: value
        }

        console_parts << opt
    }

    return console_parts
}
