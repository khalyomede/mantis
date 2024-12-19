module console

import time { now }

pub fn log(severity Severity, message string) {
    eprintln("${now().format_rfc3339_nano()} [${severity.to_string()}] ${message}")
}
