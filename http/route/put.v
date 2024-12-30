module route

import http { Route }

pub fn put(parameters Route) Route {
    return Route{
        ...parameters
        method: .put
    }
}
