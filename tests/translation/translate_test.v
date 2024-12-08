import mantis.translation { Translation }
import mantis.test { expect }

fn test_it_translate_simple_text() {
    i18n := Translation{
        keys: {
            "Hello World": {
                .en: {
                    .neutral: {
                        .any: "Hello world"
                    }
                }
                .fr: {
                    .neutral: {
                        .any: "Bonjour le monde"
                    }
                }
            }
        }
    }

    expect(i18n.translate(key: "Hello World", lang: .fr)).to_be_equal_to("Bonjour le monde")
    expect(i18n.translate(key: "Hello World", lang: .en)).to_be_equal_to("Hello world")
}

fn test_it_can_replace_count_in_translation() {
    i18n := Translation{
        keys: {
            "You have {count} new messages.": {
                .en: {
                    .neutral: {
                        .zero: "You have no messages."
                        .one: "You have a new message."
                        .many: "You have {count} new messages."
                    }
                }
                .fr: {
                    .neutral: {
                        .zero: "Vous n'avez pas de message."
                        .one: "Vous avez un nouveau message."
                        .many: "Vous avez {count} nouveaux messages."
                    }
                }
            }
        }
    }

    expect(i18n.translate(key: "You have {count} new messages.", lang: .fr, count: 3)).to_be_equal_to("Vous avez 3 nouveaux messages.")
    expect(i18n.translate(key: "You have {count} new messages.", lang: .en, count: 3)).to_be_equal_to("You have 3 new messages.")
}

fn test_it_can_replace_parameters_in_translation() {
    i18n := Translation{
        keys: {
            "The {field} is required.": {
                .en: {
                    .neutral: {
                        .any: "The {field} is required."
                    }
                },
                .fr: {
                    .neutral: {
                        .any: "Le {field} est requis."
                    }
                }
            }
        }
    }

    expect(i18n.translate(key: "The {field} is required.", lang: .fr, parameters: {"field": "nom"})).to_be_equal_to("Le nom est requis.")
    expect(i18n.translate(key: "The {field} is required.", lang: .en, parameters: {"field": "name"})).to_be_equal_to("The name is required.")
}


fn test_it_can_genderize_translation() {
    i18n := Translation{
        keys: {
            "The {item} has been sent.": {
                .en: {
                    .masculine: {
                        .any: "The {item} has been sent."
                    }
                    .feminine: {
                        .any: "The {item} has been sent."
                    }
                }
                .fr: {
                    .masculine: {
                        .any: "Le {item} a été envoyé."
                    }
                    .feminine: {
                        .any: "La {item} a été envoyé."
                    }
                }
            }
        }
    }

    expect(i18n.translate(key: "The {item} has been sent.", lang: .fr, gender: .feminine, parameters: {"item": "notification"})).to_be_equal_to("La notification a été envoyé.")
    expect(i18n.translate(key: "The {item} has been sent.", lang: .en, gender: .feminine, parameters: {"item": "notification"})).to_be_equal_to("The notification has been sent.")
}
