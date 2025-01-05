module css

pub enum Property {
    display
    align_items
}

pub fn (property Property) to_string() string {
    return match property {
        .display        { "display" }
        .align_items    { "align-items" }
    }
}
