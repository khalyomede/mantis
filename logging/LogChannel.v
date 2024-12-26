module logging

import console { Severity }

pub interface LogChannel {
    mut:
        log(severity Severity, value string)!

    debug(value string)!
}
