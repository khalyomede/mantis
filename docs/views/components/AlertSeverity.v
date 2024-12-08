module components

pub enum AlertSeverity {
    primary
}

pub fn (severity AlertSeverity) str() string {
    return match severity {
        .primary { "primary" }
    }
}
