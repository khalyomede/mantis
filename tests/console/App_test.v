import mantis.console { App, Command, Response, Argument, Example, Name, Flag, Program, Opt }
import mantis.test { expect }

fn test_it_can_return_correct_response_code_for_basic_command() {
    app := App{
        commands: [
            Command{
                name: "greet.show",
                signature: [
                    Name{"greet"}
                    Argument{name: "name", description: 'The name of the person to greet. Default to "world".'}
                    Flag{long: "force", short: "f", description: "Do not display any confirmation message."}
                    Opt{long: "suffix", short: "s", description: "A word to append after the name of the person to greet."}
                    Flag{long: "help", short: "h"}
                ]
                examples: [
                    Example{
                        description: "Greet everybody."
                        command: "greet"
                    }
                    Example{
                        description: "Greet someone."
                        command: "greet John"
                    }
                    Example{
                        description: "Greet someone and append another text to it"
                        command: 'greet Selena --suffix="and all the contributors"'
                    }
                ]
                callback: fn (mut app App) Response {
                    if app.has_flag("help") {
                        app.info(app.help_text())

                        return app.exit(0)
                    }

                    name := app.arguments.get("name") or {
                        "world"
                    }

                    app.info("Hello ${name}!")

                    return app.exit(0)
                }
            }
        ],
        console_signature: [
            Program{name: "index"}
            Name{name: "greet"}
            Argument{name: "name", value: "john"}
        ]
    }

    response := app.render()

    expect(response.code).to_be_equal_to(0)
    expect(response.output).to_be_equal_to("Hello john!")
}

fn test_it_display_help_text() {
    app := App{
        commands: [
            Command{
                name: "greet.show"
                description: "Displays a greeting message."
                signature: [
                    Name{"greet"}
                    Argument{name: "name", description: 'The name of the person to greet (default to "world").'}
                    Flag{long: "force", short: "f", description: "Do not display any confirmation message."}
                    Opt{long: "suffix", short: "s", description: "A word to append after the name of the person to greet."}
                    Flag{long: "help", short: "h", description: "Displays help instructions."}
                ]
                examples: [
                    Example{
                        description: "Greet everybody."
                        command: "greet"
                    }
                    Example{
                        description: "Greet someone."
                        command: "greet John"
                    }
                    Example{
                        description: "Greet someone and append another text to it."
                        command: 'greet Selena --suffix="and all the contributors"'
                    }
                ]
                callback: fn (mut app App) Response {
                    if app.has_flag("help") {
                        app.info(app.help_text())

                        return app.exit(0)
                    }

                    name := app.arguments.get("name") or {
                        "world"
                    }

                    app.info("Hello ${name}!")

                    return app.exit(0)
                }
            }
        ],
        console_signature: [
            Program{name: "index"}
            Name{name: "greet"}
            Flag{long: "help"}
        ]
    }

    response := app.render()

    expect(response.code).to_be_equal_to(0)
    expect(response.output).to_be_equal_to([
        "Displays a greeting message."
        ""
        "Usage:"
        ""
        "  greet [name] [...options] [...flags]"
        ""
        "Arguments:"
        ""
        '  name: The name of the person to greet (default to "world").'
        ""
        "Options:"
        ""
        "  --suffix, -s: A word to append after the name of the person to greet."
        ""
        "Flags:"
        ""
        "  --force, -f: Do not display any confirmation message."
        "  --help, -h: Displays help instructions."
        ""
        "Examples:"
        ""
        "  Greet everybody."
        "    greet"
        ""
        "  Greet someone."
        "    greet John"
        ""
        "  Greet someone and append another text to it."
        '    greet Selena --suffix="and all the contributors"'
    ].join("\n"))
}
