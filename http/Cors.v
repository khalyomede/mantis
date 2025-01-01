module http

import cors

pub struct Cors {
    pub:
        // TODO: Duration helper (suggested usage: Duration{}.two(.hour).in_seconds()))
        max_age_in_seconds ?u32
        allowed_origins ?[]string
        allowed_headers ?[]string
        credentials bool
}

pub fn (original Cors) max_age() u32 {
    return original.max_age_in_seconds or { cors.default_max_age }
}

pub fn (original Cors) headers() []string {
    return original.allowed_headers or { cors.default_headers }
}

pub fn (original Cors) origins() []string {
    return original.allowed_origins or { cors.default_origins }
}

fn (original Cors) merge(new Cors) Cors {
    return Cors{
        max_age_in_seconds: new.max_age_in_seconds or {
            original.max_age_in_seconds or { cors.default_max_age }
        }
        allowed_origins: new.allowed_origins or {
            original.allowed_origins or { cors.default_origins }
        }
        allowed_headers: new.allowed_headers or {
            original.allowed_headers or { cors.default_headers }
        }
        credentials: new.credentials || original.credentials
    }
}
