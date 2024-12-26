module logging

import console { Severity }

pub interface LogChannel {
    mut:
        log(severity Severity, value string)!

    emergency(value string)!
    alert(value string)!
    critical(value string)!
    error(value string)!
    warning(value string)!
    notice(value string)!
    info(value string)!
    debug(value string)!
}
