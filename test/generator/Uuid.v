module generator

import rand

pub struct Uuid {}

pub fn (uuid Uuid) v4() string {
    return rand.uuid_v4()
}
