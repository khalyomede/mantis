module http

pub enum Method {
    connect
    delete
    get
    post
}

pub fn (method Method) to_string() string {
    return match method {
        .connect    { "CONNECT" }
        .delete     { "DELETE" }
        .get        { "GET" }
        .post       { "POST" }
    }
}
