module css

pub struct Selector {
    pub:
        selector string
        blocks []SelectorBlock
}

pub fn (selector Selector) to_string() string {
    mut content := []string{}
    mut scope := []string{}

    scope << selector.selector
    scope << "{"

    content << scope.join("")

    for block in selector.blocks {
        content << match block {
            Rule {
                block.to_string()
            }

            Selector {
                block.to_string()
            }
        }
    }

    content << ""
    content << "}"

    return content.join("")
}
