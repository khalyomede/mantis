module css

pub struct Rule {
    pub:
        property Property
        value string
        lonely bool
}

pub fn (rule Rule) to_string() string {
    mut content := []string{}

    content << "${rule.property.to_string()}:"
    content << "${rule.value}"
    content << if rule.lonely { "" } else { ";" }

    return content.join("")
}
