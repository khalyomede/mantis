module generator

import rand
import data

pub struct CountryCode {}

pub fn (country_code CountryCode) alpha2() string {
    return rand.element(data.country_codes_alpha2) or { "us" }
}

pub fn (country_code CountryCode) alpha3() string {
    return rand.element(data.country_codes_alpha3) or { "usa" }
}
