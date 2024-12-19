module http

pub struct CreateUrlParameters {
    pub:
        path string
        queries map[string]string
}

pub fn create_url(parameters CreateUrlParameters) Url {
    return Url{
        paths: parameters.path.trim_left("/").trim_right("/").split("/")
        queries: parameters.queries
    }
}
