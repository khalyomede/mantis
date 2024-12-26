module console

pub enum Severity {
    emergency
    alert
    critical
    error
    warning
    notice
    info
    debug
}

pub fn (severity Severity) to_string() string {
    return match severity {
        .debug      { "DBUG" }
        .info       { "INFO" }
        .notice     { "NTCE" }
        .warning    { "WARN" }
        .error      { "ERRO" }
        .critical   { "CRIT" }
        .alert      { "ALRT" }
        .emergency  { "EMRG" }
    }
}
