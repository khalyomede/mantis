module http

pub enum Method {
    get
    post
}

pub fn (method Method) to_string() string {
    return match method {
        .get    { "GET" }
        .post   { "POST" }
    }
}
