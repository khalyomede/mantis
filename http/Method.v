module http

pub enum Method {
    connect
    get
    post
}

pub fn (method Method) to_string() string {
    return match method {
        .connect    { "CONNECT" }
        .get        { "GET" }
        .post       { "POST" }
    }
}
