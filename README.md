# Mantis

Type-safe, exception-free no magic web framework for people that like to sleep at night.

```v
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    cpus: 8
    routes: [
      route.get(path: "/", callback: fn (app App) !Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

## Documentation

Browse [khalyomede.github.io/mantis](https://khalyomede.github.io/mantis).

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

██░░░░░░░░░░░░░░░░░░ (26/106 - 24%)

- Routing
  - ✅ Get routes
  - ✅ Post routes
  - ✅ Routes with parameters
- Middlewares
  - Global middlewares
    - ⏳ before route matching
    - ⏳ after route matching
  - Route-level middlewares
    - ⏳ before route renders
    - ⏳ after route renders
- Views
  - ⏳ HTML components
  - ⏳ HTML enum attributes
  - ⏳ Static pages
- Translations / internationalization (i18n)
  - ✅ Simple texts
  - ✅ Translation parameters
  - ✅ Singular/plural translation
  - ✅ Gender translation (feminine/masculine)
- Session management
  - Drivers
    - ✅ Local file
    - ✅ Cookie (client read-only)
    - ⏳ Database
    - ⏳ Redis
- Validation
  - ✅ Basic validation
  - ⏳ Rules
  - ⏳ And, Or, Not
  - ⏳ Validation helper
  - ✅ Custom rules
- Request
  - ✅ Parsing query
  - ✅ Parsing body
  - ⏳ Form integrity checker
  - ⏳ Multipart/form-data form file parsing
- Url
  - ✅ Url builder
- Response
  - ✅ Basic HTML response
  - ✅ Response headers
  - ✅ Redirect responses
  - ⏳ Streamed response
  - ⏳ Keep-alive response
  - ⏳ Chunked transfer encoding
- Environment
  - ✅ Dot env embeded values
  - ⏳ Nested envs in other envs
- Database
  - ⏳ Max connections settings (with wait mecanism)
  - ✅ Typed MySQL query result (struct)
  - ⏳ Support for relationships
  - Drivers
    - ⏳ MySQL/MariaDB
    - ⏳ Postgres
    - ✅ Sqlite
    - ⏳ Local file
    - ⏳ Migrations
    - ⏳ Seeders
- Real time
  - Web socket drivers
    - ⏳ Server-Side Events (SSE)
  - Push notification drivers
    - ⏳ Local file
    - ⏳ Firebase
    - ⏳ Pusher
- Security
  - Authentication drivers
    - ⏳ Database
  - Single Sign-On
    - ⏳ Google
    - ⏳ Facebook
    - ⏳ Apple
    - ⏳ Twitter
    - ⏳ Linkedin
    - ⏳ Github
  - Views
    - ⏳ XSS protection
  - Session
    - ⏳ Encrypted session ids (read-only Cookie / File-based session)
    - ⏳ CSRF protection
    - ⏳ Rate limit helper
  - Encryption
    - ⏳ Crypt/decrypt helper
  - Password hasher
    - ⏳ Password Hash helper
  - Validation
    - ⏳ Escaping HTML inside string values
  - Url
    - ⏳ Escaping URL parts
  - Request
    - ⏳ Form body size limit
- Communication
  - ⏳ HTTP client
  - Email driver
    - ⏳ Local file
    - ⏳ Mailtrap
    - ⏳ SMTP mailer
  - SMS drivers
    - ⏳ Local file
    - ⏳ Vonage
    - ⏳ Twilio
- File storage drivers
  - ⏳ Local file
  - ⏳ AWS S3
- Task scheduling
  - ⏳ Command builder
  - ⏳ Cron scheduler
- Background task drivers
  - ⏳ Local file
  - ⏳ Database
- Monitoring
  - Logging drivers
    - ✅ Local file
    - ⏳ Syslog
    - ⏳ Papertrail
  - Error tracking drivers
    - ⏳ Local file
    - ⏳ Sentry
- Local development
  - Local running
    - ⏳ Docker image
  - Testing
    - ⏳ Unit test helpers
    - ⏳ Mocking utilities
  - Assets bundling
    - ⏳ Vite.js
    - ⏳ Static file serving
- Performance
  - ⏳ Improved concurrency performance
  - ⏳ Memory efficient Fake data generator
- Production running
  - ⏳ On-demand mode
  - ✅ Standalone mode (multi-cores)
  - ⏳ Zero traffic-loss live-code update (no downtime deployment)
  - ⏳ Embeded HTTPS/SSL request handling
- Testing
  - ✅ Expect test-style
  - ⏳ HTTP expectations
  - ⏳ Error stack trace (like built-in assert)
  - ✅ Fake data generator
- Comparisons
  - ✅ Laravel
  - ⏳ Rails
  - ⏳ AdonisJS
  - ⏳ Express
  - ⏳ Gin
- Examples
  - ⏳ With HTMX
  - ⏳ Inertia adapter
- ✅ Online documentation
