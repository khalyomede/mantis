module console

pub struct Opt {
    pub:
        long string
        short string
        description string

    value string
}

// Think of a way to mutualize these 4 next methods with Flag.
pub fn (option Opt) has_all_variants() bool {
    return option.has_long_variant() && option.has_short_variant()
}

pub fn (option Opt) has_long_variant() bool {
    return option.long.trim_space().len > 0
}

pub fn (option Opt) has_short_variant() bool {
    return option.short.trim_space().len > 0
}

pub fn (option Opt) has_description() bool {
    return option.description.trim_space().len > 0
}
