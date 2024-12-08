module translation

pub fn (t Translation) translate(params TranslateParams) string {
    // Get translations for this language and key
    countable := if params.count == 0 {
        Countable.zero
    } else if params.count == 1 {
        Countable.one
    } else if params.count > 1 {
        Countable.many
    } else {
        Countable.any
    }

    mut text := t.keys[params.key][params.lang][params.gender][countable] or { return params.key }

    // Handle other replacements
    for parameter_key, parameter_value in params.parameters {
        text = text.replace('{${parameter_key}}', parameter_value)
    }

    if params.count > -1 {
        text = text.replace('{count}', params.count.str())
    }

    return text
}
