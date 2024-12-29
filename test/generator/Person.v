module generator

import rand
import data

pub struct Person {}

pub fn (person Person) first_name() string {
    return rand.element(data.person_first_names) or { "" }
}

pub fn (person Person) last_name() string {
    return rand.element(data.person_last_names) or { "" }
}

pub fn (person Person) name() string {
    return person.first_name() + " " + person.last_name()
}
