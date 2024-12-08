module http

pub struct Request {
    pub:
        path string
        method Method
        ip string
        http_version string
        headers map[string][]string
        queries map[string]string
        form map[string]string
        cookies Cookies
}

pub fn (request Request) query(key string) ?string {
    return request.queries[key] or {
        none
    }
}

pub fn (request Request) form(key string) ?string {
    return request.form[key] or { none }
}
