module route

import http { Route }

pub fn delete(parameters Route) Route {
    return Route{
        ...parameters
        method: .delete
    }
}
