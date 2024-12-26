module logging

import console { Severity }

pub struct Log implements LogChannel {
    pub mut:
        channel LogChannel
}

pub fn (mut log Log) log(severity Severity, value string) ! {
    log.channel.log(severity, value)!
}

pub fn (mut log Log) emergency(value string) ! {
    log.channel.emergency(value)!
}

pub fn (mut log Log) alert(value string) ! {
    log.channel.alert(value)!
}

pub fn (mut log Log) critical(value string) ! {
    log.channel.critical(value)!
}

pub fn (mut log Log) error(value string) ! {
    log.channel.error(value)!
}

pub fn (mut log Log) warning(value string) ! {
    log.channel.warning(value)!
}

pub fn (mut log Log) notice(value string) ! {
    log.channel.notice(value)!
}

pub fn (mut log Log) info(value string) ! {
    log.channel.info(value)!
}


pub fn (mut log Log) debug(value string) ! {
    log.channel.debug(value)!
}
