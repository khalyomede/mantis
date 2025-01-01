module http

import regex

type Parameter = fn (string) bool

pub struct Route {
    pub:
        name string
        path string
        method Method = .get
        callback fn (App) !Response @[required]
}

fn (route Route) matches(request Request) bool {
    // Allow HEAD requests to match GET routes
    if request.method == .head && route.method == .get {
        return route.matches_path(request.path)
    }

    if route.method != request.method {
        return false
    }

    return route.matches_path(request.path)
}

fn (route Route) matches_path(path string) bool {
    // Build regex pattern by replacing {param} with ([^/]+)
    mut pattern := path

    // Extract parameter names from route
    mut re := regex.regex_opt(r"\{([^}]+)\}") or {
        return false
    }

    param_names := re.find_all_str(route.path)
        .map(it.trim_string_left('{').trim_string_right('}'))

    // Replace each {param} with capture group for any non-slash characters
    for name in param_names {
        pattern = pattern.replace('{${name}}', '([^/]+)')
    }

    // Create final pattern with start/end anchors
    re = regex.regex_opt('^${pattern}$') or {
        return false
    }

    return re.matches_string(path)
}

pub fn (route Route) parameters(path string) ?map[string]string {
    // Extract parameter names from route
    mut re := regex.regex_opt(r"\{([^}]+)\}") or {
        return none
    }
    param_names := re.find_all_str(route.path)
        .map(it.trim_string_left('{').trim_string_right('}'))

    // Build regex pattern by replacing {param} with ([^/]+)
    mut pattern := route.path
    for name in param_names {
        pattern = pattern.replace('{${name}}', '([^/]+)')
    }

    // Match path against pattern
    re = regex.regex_opt('^${pattern}$') or {
        return none
    }

    if !re.matches_string(path) {
        return none
    }

    // Extract values from captures
    mut values := []string{}
    for group in re.get_group_list() {
        value := path.substr(group.start, group.end)
        if value.len == 0 {
            return none
        }
        values << value
    }

    if values.len != param_names.len {
        return none
    }

    // Build parameter map
    mut parameters := map[string]string{}
    for i := 0; i < param_names.len; i++ {
        parameters[param_names[i]] = values[i]
    }

    return parameters
}
