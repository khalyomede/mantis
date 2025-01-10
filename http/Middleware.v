module http

pub type Middleware = fn (app App) !Response
