module route

import http { Route }

pub fn post(parameters Route) Route {
    return Route{
        ...parameters
        method: .post
    }
}
