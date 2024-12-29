import http { Url }
import test { expect, Fake }

const fake := Fake{}

fn test_can_build_url_with_scheme_domain_and_tld() {
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain()

    url := Url{
        scheme: .https
        domain: domain
        tld: tld
    }

    expect(url.str()).to_be_equal_to('https://${domain}.${tld}')
}

fn test_can_build_url_with_subdomain() {
    sub_domain := fake.word().to_lower()
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain()

    url := Url{
        scheme: .https
        sub_domain: sub_domain
        domain: domain
        tld: tld
    }

    expect(url.str()).to_be_equal_to('https://${sub_domain}.${domain}.${tld}')
}

fn test_can_build_url_with_port() {
    domain := fake.internet.domain()
    port := fake.internet.port()

    url := Url{
        scheme: .http
        domain: domain
        tld: ''
        port: port
    }

    expect(url.str()).to_be_equal_to('http://${domain}:${port}')
}

fn test_can_build_url_with_paths() {
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain()
    post_id := fake.database.primary_key()

    url := Url{
        scheme: .https
        domain: domain
        tld: tld
        paths: ['blog', 'posts', post_id.str()]
    }

    expect(url.str()).to_be_equal_to('https://${domain}.${tld}/blog/posts/${post_id}')
}

fn test_can_build_url_with_query_parameters() {
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain()
    page := fake.integer.between(1, 10)

    url := Url{
        scheme: .https
        domain: domain
        tld: tld
        paths: ['search']
        queries: {
            'q': 'hello world'
            'page': page.str()
        }
    }

    expect(url.str()).to_be_equal_to('https://${domain}.${tld}/search?q=hello+world&page=${page}')
}

fn test_can_build_url_with_hash() {
    domain := fake.internet.domain()
    tld := fake.internet.top_level_domain()

    url := Url{
        scheme: .https
        domain: domain
        tld: tld
        hash: 'section-1'
    }

    expect(url.str()).to_be_equal_to('https://${domain}.${tld}#section-1')
}
