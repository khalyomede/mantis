module http

pub enum Method {
    connect
    delete
    get
    head
    options
    patch
    post
    put
    trace
}

pub fn (method Method) to_string() string {
    return match method {
        .connect    { "CONNECT" }
        .delete     { "DELETE" }
        .get        { "GET" }
        .head       { "HEAD" }
        .options    { "OPTIONS" }
        .patch      { "PATCH" }
        .post       { "POST" }
        .put        { "PUT" }
        .trace      { "TRACE" }
    }
}
