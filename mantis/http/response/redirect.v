module response

import mantis.http { Response, Status, create_url }

pub fn redirect(path string, queries map[string]string) Response {
    redirect_path := create_url(path: path, queries: queries)

    return Response{
        content: ''
        status: .found
        headers: {
            'Location': [redirect_path.str()]
        }
    }
}
