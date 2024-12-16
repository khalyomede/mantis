module http

pub enum Status {
    ok
    created
    found
    bad_request
    not_found
    unprocessable_entity
    server_error
}

pub fn (status Status) to_string() string {
    return match status {
        .ok                     { "OK" }
        .created                { "CREATED" }
        .found                  { "FOUND" }
        .bad_request            { "BAD REQUEST" }
        .not_found              { "NOT FOUND" }
        .unprocessable_entity   { "UNPROCESSABLE ENTITY" }
        .server_error           { "SERVER ERROR" }
    }
}

pub fn (status Status) to_int() int {
    return match status {
        .ok                     { 200 }
        .created                { 201 }
        .found                  { 302 }
        .bad_request            { 400 }
        .unprocessable_entity   { 400 }
        .not_found              { 404 }
        .server_error           { 500 }
    }
}
