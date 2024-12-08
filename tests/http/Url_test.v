import mantis.http { Url }
import mantis.test { expect }

fn test_can_build_url_with_scheme_domain_and_tld() {
    url := Url{
        scheme: .https
        domain: 'example'
        tld: 'com'
    }

    expect(url.str()).to_be_equal_to('https://example.com')
}

fn test_can_build_url_with_subdomain() {
    url := Url{
        scheme: .https
        sub_domain: 'blog'
        domain: 'example'
        tld: 'com'
    }

    expect(url.str()).to_be_equal_to('https://blog.example.com')
}

fn test_can_build_url_with_port() {
    url := Url{
        scheme: .http
        domain: 'localhost'
        tld: ''
        port: 8080
    }

    expect(url.str()).to_be_equal_to('http://localhost:8080')
}

fn test_can_build_url_with_paths() {
    url := Url{
        scheme: .https
        domain: 'example'
        tld: 'com'
        paths: ['blog', 'posts', '123']
    }

    expect(url.str()).to_be_equal_to('https://example.com/blog/posts/123')
}

fn test_can_build_url_with_query_parameters() {
    url := Url{
        scheme: .https
        domain: 'example'
        tld: 'com'
        paths: ['search']
        queries: {
            'q': 'hello world'
            'page': '1'
        }
    }

    expect(url.str()).to_be_equal_to('https://example.com/search?q=hello+world&page=1')
}

fn test_can_build_url_with_hash() {
    url := Url{
        scheme: .https
        domain: 'example'
        tld: 'com'
        hash: 'section-1'
    }

    expect(url.str()).to_be_equal_to('https://example.com#section-1')
}
