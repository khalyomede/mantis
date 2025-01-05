module css

pub struct Supports {
    pub:
        rules []Rule
        blocks []SelectorBlock
}

pub fn (supports Supports) to_string() string {
    mut content := []string{}
    mut rules_statement := []string{}

    for rule in supports.rules {
        rules_statement << "(${rule.to_string()})"
    }

    content << "@supports"
    content << rules_statement.join(" and ")
    content << "{"
    content << ""

    for block in supports.blocks {
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
