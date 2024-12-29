module test

import generator { Person, Database, Integer, Country, Internet, Company, Uuid }
import generator.data
import rand

// TODO: refactor data to use txt files
// and consts with line counts to loop
// through each lines to reduce memory usage.
pub struct Fake {
    pub:
        person Person
        database Database
        integer Integer
        country Country
        internet Internet
        company Company
        uuid Uuid
}

pub fn (fake Fake) sentence() string {
    return rand.element(data.sentences) or { "" }
}

pub fn (fake Fake) lang() string {
    return rand.element(data.langs) or { "en" }
}

pub fn (fake Fake) email() string {
    first_name := fake.person.first_name().replace(" ", "-") // TODO: use String{...}.to_hyphen()
    last_name := fake.person.last_name().replace(" ", "-") // TODO: use String{...}.to_hyphen()
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain() // TODO: make a fake.internet.domain_name()

    return "${first_name}.${last_name}@${domain}.${tld}".to_lower()
}

pub fn (fake Fake) negative_integer() i64 {
    integer := rand.i64()

    return if integer < 0 { integer } else { -integer }
}

pub fn (fake Fake) word() string {
    return rand.element(data.words) or { "code" }
}
