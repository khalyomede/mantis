module generator

pub struct Database {}

pub fn (database Database) primary_key() int {
    return Integer{}.between(1, max_int)
}
