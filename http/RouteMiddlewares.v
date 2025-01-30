module http

pub struct RouteMiddlewares {
    pub:
        before_response_rendered []Middleware
        after_response_rendered []Middleware
}
