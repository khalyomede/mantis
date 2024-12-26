module channel

import console { Severity }
import logging { LogChannel }
import os
import time { now }

pub struct File implements LogChannel {
    pub:
        path string

    mut:
        disk_file os.File
}

pub fn (mut file File) log(severity Severity, value string) ! {
    file.open()!

    defer {
        file.close()
    }

    file.disk_file.write_string("\n[${now().format_rfc3339_nano()}] [${severity.str()}] ${value}")!
}

pub fn (mut file File) debug(value string) ! {
    file.log(.debug, value)!
}

fn (mut file File) open() ! {
    if file.disk_file.is_opened {
        return
    }

    file.disk_file = os.open_append(file.path)!
}

fn (mut file File) close() {
    file.disk_file.close()
}
