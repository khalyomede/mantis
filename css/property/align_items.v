module property

import css { Rule }

pub fn align_items(type AlignItems) Rule {
    return Rule {
        property: .align_items
        value: type.to_string()
    }
}
