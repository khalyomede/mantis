module http

pub enum Method {
    connect
    delete
    get
    head
    options
    post
}

pub fn (method Method) to_string() string {
    return match method {
        .connect    { "CONNECT" }
        .delete     { "DELETE" }
        .get        { "GET" }
        .head       { "HEAD" }
        .options    { "OPTIONS" }
        .post       { "POST" }
    }
}
