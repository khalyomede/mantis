module http

pub struct Url {
    pub:
        scheme Scheme = .undefined
        sub_domain string
        domain string
        tld string // TODO: rename to "top_level_domain"
        port u16
        paths []string
        queries map[string]string
        hash string
}

pub fn (url Url) str() string {
    mut raw_url := ""

    if url.scheme != .undefined {
        raw_url = "${url.scheme}://"
    }

    if url.sub_domain.trim_space().len > 0 {
        raw_url = "${raw_url}${url.sub_domain}."
    }

    raw_url = "${raw_url}${url.domain}"

    if url.tld.len > 0 {
        raw_url = "${raw_url}.${url.tld}"
    }

    if url.port > 0 {
        raw_url = "${raw_url}:${url.port}"
    }

    if url.paths.len > 0 {
        raw_url = "${raw_url}/" + url.paths.map(it.trim_space().replace(" ", "")).join("/")
    }

    if url.queries.len > 0 {
        mut query_list := []string{}

        for key, value in url.queries {
            query_list << "${encode_url(key)}=${encode_url(value)}"
        }

        raw_url = "${raw_url}?" + query_list.join("&")
    }

    if url.hash.trim_space().len > 0 {
        raw_url = "${raw_url}#${url.hash}"
    }

    return raw_url
}
