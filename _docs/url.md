# URL

Mantis provides a type-safe way to create and manipulate URLs.

## Creating URLs

Use `create_url` to build URLs with proper encoding:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_url }

fn main() {
  // Simple URL
  url := create_url(
    path: "/blog/posts"
  )

  println(url.str()) // "/blog/posts"

  // URL with query parameters
  url_with_query := create_url(
    path: "/search"
    queries: {
      "q": "hello world"
      "page": "1"
    }
  )

  println(url_with_query.str()) // "/search?q=hello+world&page=1"
}
```

:::

## URL Components

URLs can include various components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { Url }

fn main() {
  url := Url{
    scheme: .https
    sub_domain: "blog"
    domain: "example"
    tld: "com"
    paths: ["posts", "2024", "hello-world"]
    queries: {
      "utm_source": "twitter"
      "utm_medium": "social"
    }
    hash: "comments"
    port: 8080
  }

  println(url.str()) // "https://blog.example.com:8080/posts/2024/hello-world?utm_source=twitter&utm_medium=social#comments"
}
```

:::

### URL Encoding/Decoding

Safely encode and decode URL components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { encode_url, decode_url }

fn main() {
  // Encoding
  encoded := encode_url("hello world & more")

  println(encoded) // "hello+world+%26+more"

  // Decoding
  decoded := decode_url("hello+world+%26+more")

  println(decoded) // "hello world & more"
}
```

:::

## Supported Schemes

Mantis supports various URL schemes:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { Url }

fn main() {
  // HTTP/HTTPS
  http_url := Url{
    scheme: .http
    domain: "localhost"
    port: 8080
  }

  // HTTPS
  https_url := Url{
    scheme: .https
    domain: "example"
    tld: "com"
  }

  // WebSocket
  ws_url := Url{
    scheme: .ws
    domain: "socket"
    tld: "example.com"
  }

  // Other supported schemes:
  // - .wss (Secure WebSocket)
  // - .mailto
  // - .tel
  // - .slack
  // - .s3
}
```

:::
