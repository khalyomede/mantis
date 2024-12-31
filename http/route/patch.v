module route

import http { Route }

pub fn patch(parameters Route) Route {
    return Route{
        ...parameters
        method: .patch
    }
}
