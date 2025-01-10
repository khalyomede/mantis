module http

pub struct Response {
    pub:
        content string
        status Status = .ok
        headers map[string][]string = {}
}

pub struct HtmlParameters {
    pub:
        content string
        status Status = .ok
}

pub struct RedirectParameters {
    pub:
        path string
        queries map[string]string
}

pub fn (response Response) html(parameters HtmlParameters) Response {
    return Response {
        ...response
        content: parameters.content
        status: parameters.status
        headers: {
            ...response.headers
            HeaderType.content_type.to_string(): [Mime.text_html.to_string()]
        }
    }
}

pub fn (response Response) set_header(key string, value string) Response {
    return Response {
        ...response
        headers: {
            ...response.headers
            key: [value]
        }
    }
}

pub fn (response Response) redirect(parameters RedirectParameters) Response {
    redirect_path := create_url(path: parameters.path, queries: parameters.queries)

    return Response{
        content: ''
        status: .found
        headers: {
            ...response.headers
            HeaderType.location.to_string(): [redirect_path.str()]
        }
    }
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
