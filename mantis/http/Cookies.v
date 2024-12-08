module http

pub type Cookies = map[string]string

pub fn (cookies Cookies) get(key string) ?string {
    return cookies[key] or { none }
}
