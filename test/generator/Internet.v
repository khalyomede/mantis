module generator

import data
import math { max }
import rand

pub struct Internet {}

pub fn (internet Internet) domain() string {
    return rand.element(data.internet_domains) or { "example" }
}

pub fn (internet Internet) top_level_domain() string {
    return rand.element(data.internet_top_level_domains) or { "com" }
}

pub fn (internet Internet) port() u16 {
    return max(rand.u16(), 1000)
}
