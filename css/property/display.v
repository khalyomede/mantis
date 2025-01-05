module property

import css { Rule }

pub fn display(type Display) Rule {
    return Rule {
        property: .display
        value: type.to_string()
    }
}
