module http

pub enum Status {
    ok
    found
    not_found
    server_error
}

pub fn (status Status) to_string() string {
    return match status {
        .ok             { "OK" }
        .found          { "FOUND" }
        .not_found      { "NOT FOUND" }
        .server_error   { "SERVER ERROR" }
    }
}

pub fn (status Status) to_int() int {
    return match status {
        .ok             { 200 }
        .found          { 302 }
        .not_found      { 404 }
        .server_error   { 500 }
    }
}
