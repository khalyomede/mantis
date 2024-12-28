module logging

import console { Severity }

pub struct Log implements LogChannel {
    pub mut:
        channel LogChannel = Console{}
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

struct Console implements LogChannel {}

fn (mut c Console) log(severity Severity, value string) ! {
    console.log(severity, value)
}

fn (mut c Console) emergency(value string) ! {
    console.log(.emergency, value)
}

fn (mut c Console) alert(value string) ! {
    console.log(.alert, value)
}

fn (mut c Console) critical(value string) ! {
    console.log(.critical, value)
}

fn (mut c Console) error(value string) ! {
    console.log(.error, value)
}

fn (mut c Console) warning(value string) ! {
    console.log(.warning, value)
}

fn (mut c Console) notice(value string) ! {
    console.log(.notice, value)
}

fn (mut c Console) info(value string) ! {
    console.log(.info, value)
}


fn (mut c Console) debug(value string) ! {
    console.log(.debug, value)
}
