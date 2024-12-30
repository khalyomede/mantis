module http

pub enum Method {
    connect
    delete
    get
    head
    post
}

pub fn (method Method) to_string() string {
    return match method {
        .connect    { "CONNECT" }
        .delete     { "DELETE" }
        .get        { "GET" }
        .head       { "HEAD" }
        .post       { "POST" }
    }
}
