# Mantis

Type-safe, exception-free no magic web framework for people that like to sleep at night.

```v
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route

fn main() {
  app := create_app(
    cpus: 8
    routes: [
      route.get(path: "/", callback: fn (app App) !Response {
        return app.response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

## Documentation

Browse [khalyomede.github.io/mantis](https://khalyomede.github.io/mantis).

## Updates

Follow me for updates and feel free to DM/tweet for questions:

https://x.com/anwar_nairi

_Currently reworking internals to split key parts (query builder, router, ...) into separate V packages._

## License

Mantis is open-sourced software licensed under the [MIT license](LICENSE.md).

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## Alternatives

- [veb](https://modules.vlang.io/veb.html): the official V web framework
- [awesome-v](https://github.com/vlang/awesome-v): a curated list of V packages including web tools
- [vpm](https://vpm.vlang.io/): the official V package registry

## Run tests

```bash
v -stats -N -W test .
```

## Roadmap

_This is just informative and plan may change a little bit according to priorities given the fact I work on it on my free time. Bare with me and thanks for your patience!_

0.0.1 has all features in this repository. The next version will explode the core in several packages for wide spread use and ease of maintenance.


- [x] [khalyomede/commander](https://github.com/khalyomede/commander): A package to create command line applications.
- [x] [khalyomede/expect](https://github.com/khalyomede/expect): An expect-style testing utility.
- [x] [khalyomede/faker](https://github.com/khalyomede/faker): Generate fake data for your tests.
- [x] [khalyomede/url](https://github.com/khalyomede/url): A simple URL builder utility.
- [x] [khalyomede/el](https://github.com/khalyomede/el): Type safe HTML views as function.
- [x] [khalyomede/lang](https://github.com/khalyomede/lang): A enum of all existing lang.
- [x] [khalyomede/ip](https://github.com/khalyomede/ip): An IP v4 / v6 compatible struct to parse and render IPs.
- [ ] [khalyomede/mime](https://github.com/khalyomede/mime): An enum with common MIME types.
- [ ] [khalyomeder/web](https://github.com/khalyomede/web): Request/response utilities.
- [ ] khalyomede/mantis: A battery included web framework.
- [ ] khalyomede/server: A simple HTTP web server.
- [ ] khalyomede/router: A simple string/handler based HTTP router.
- [ ] khalyomede/crypt: Encryption/decryption utilities.
- [ ] khalyomede/hash: A simple hash function supporting multiple algorithm.
- [ ] khalyomede/database: Unified database connector.
khalyomede/query: A unified query builder for SQL relational databases.
- [ ] khalyomede/logger: A multi-channel logger.
khalyomede/validation: Validate primritives types and struct.
- [ ] khalyomede/cache: A unified cache mecanism supporting various drivers.
- [ ] khalyomede/file: A unified file read/write package supporting various drivers.
- [ ] khalyomede/mail: A unifid email sending package supporting various drivers.
- [ ] khalyomede/limiter: A cache-based rate limiter.
