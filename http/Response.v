module http

pub struct Response {
    pub:
        content string
        status Status = .ok
        headers map[string][]string = {}
}

fn (response Response) raw_headers() string {
    mut headers_str := ''

    for name, values in response.headers {
        for value in values {
            headers_str += '${name}: ${value}\n'
        }
    }

    return headers_str
}
