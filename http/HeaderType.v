module http

pub enum HeaderType {
    accept
    content_type
    location
}

pub fn (header_type HeaderType) to_string() string {
    return match header_type {
        .accept { "Accept" }
        .content_type { "Content-Type" }
        .location { "Location" }
    }
}
