module logging

import console { Severity }

pub struct Log implements LogChannel {
    pub mut:
        channel LogChannel
}

pub fn (mut log Log) log(severity Severity, value string) ! {
    log.channel.log(severity, value)!
}

pub fn (mut log Log) debug(value string) ! {
    log.channel.debug(value)!
}
