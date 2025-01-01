# Introduction

## What is Mantis?

Mantis is a web framework for [V lang](https://vlang.io/) that that emphasize on explicit code and type safety.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    cpus: 8
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) !Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Why using Mantis?

Mantis promise is to be a high-level toolbox for your API and web apps. It offers:

- HTTP utilities (form/query parsing, HTML responses, ...)
- Console routing (for background jobs, ...)
- Database connector
- Type-safe HTML utilities (for your layouts/pages/components)
- Session handling
- Embeded Environment
- Data validation utilities
- Error handling/reporting
- An i18n/internationalization utility for your translated terms
- An expect-style testing framework
- Single file executable server (compatible with Mac/Linux)

## V lang

V is a modern type-safe immutable fast general purpose programming language. Think of [Go](https://go.dev/) with the strict-typing and simple syntax you were expecting.

::: tip NOTICE
Mantis is not replacing [veb](https://github.com/vlang/v/tree/master/vlib/veb), the official V web framework. Please check it first to see if it fits your needs.
:::

## Supported V versions

Mantis support V > 0.4.8.
