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

pub fn (internet Internet) base_url() string {
    protocol := internet.protocol()
    domain := internet.domain()
    top_level_domain := internet.top_level_domain()

    return "${protocol}://${domain}.${top_level_domain}"
}

pub fn (internet Internet) protocol() string {
    return rand.element(data.internet_protocols) or { "http" }
}
