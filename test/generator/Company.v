module generator

import data
import rand

pub struct Company {}

pub fn (company Company) name() string {
    return rand.element(data.company_names) or { "Google" }
}
