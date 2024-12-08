module response

import mantis.http { Response }

pub fn html(parameters Response) Response {
    response_headers := {
        ...parameters.headers,
        "Content-Type": ["text/html"]
    }

    return Response{
        ...parameters,
        headers: response_headers
    }
}
