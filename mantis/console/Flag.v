module console

pub struct Flag {
    pub:
        long string
        short string
        description string
}

pub fn (flag Flag) has_all_variants() bool {
    return flag.has_long_variant() && flag.has_short_variant()
}

pub fn (flag Flag) has_long_variant() bool {
    return flag.long.trim_space().len > 0
}

pub fn (flag Flag) has_short_variant() bool {
    return flag.short.trim_space().len > 0
}

pub fn (flag Flag) has_description() bool {
    return flag.description.trim_space().len > 0
}
