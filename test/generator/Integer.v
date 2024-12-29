module generator

import rand
import math

pub struct Integer {}

pub fn (integer Integer) between(min int, max int) int {
    return math.min(rand.int_in_range(min, max) or { min }, max_int)
}
