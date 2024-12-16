# Mantis

Type-safe, exception-free no magic web framework for people that like to sleep at night.

```v
module main

import mantis.http { create_app, Response }
import mantis.http.route
import mantis.http.response

fn main() {
  app := create_app(
    cpus: 8
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

## Philosophy

Mantis embraces explicit over implicit, making code easy to follow and maintain:

- No hidden middleware chains
- Type-safe from database to views
- Function-based components for clear dependencies
- Explicit error handling
- Clear and predictable request flow

## Pre-release disclaimer

Mantis is not ready for production. The online documentation is not done yet.

However if you're already enthusiastic about it, the best way to get a deeper understanding of how to use it is to dive into the "tests" folder.

## Suggested folder structure

```bash
your-app
├── actions
│   └── post
│     ├── store.v
│     └── find.v
├── commands
│   └── post
│     ├── find.v
│     └── store.v
├── controllers
│   ├── index.v
│   └── post
│     ├── create.v
│     ├── find.v
│     └── store.v
├── validators
│   └── post
│     └── store.v
├── views
│   ├── components
│   │   └── dropdown.v
│   └── layouts
│     ├── guest.v
│     └── logged.v
└── main.v
```

## Getting started

Get a little knowledge on:

- [V lang](https://vlang.io/) (the programming language used within this framework)
- [Docker](https://docs.docker.com/get-started/docker-overview/) & [Docker Compose](https://docs.docker.com/compose/intro/compose-application-model/) (no deep understanding, just basics)

In your "index.v" file, write the minimal code:

```v
module main

import mantis.http { create_app, Response }
import mantis.http.route
import mantis.http.response

fn main() {
  app := App{
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      }}
    ]
  }

  app.serve() or { panic(err) }
}
```

Create a "docker-compose.yml" file and paste this code:

```yml
services:
  v:
  image: thevlang/vlang:alpine
  tty: true
  entrypoint: v
  working_dir: /home/v
  volumes:
    - .:/home/v
  ports:
    - 80:80
```

Run these commands:

```bash
docker compose up -d
docker compose exec v sh
```

Then inside the container start the server:

```bash
v watch run main.v
```

Now you should be able to view your app at [http://localhost](http://localhost) or [http://127.0.0.1](http://127.0.0.1).

## Compile for production

```bash
v -N -W -prod -os linux -obfuscate -skip-unused -o main main.v
chmod +x -r -w main
```

## License

Mantis is open-sourced software licensed under the [MIT license](LICENSE.md).

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## Roadmap

██░░░░░░░░░░░░░░░░░░ (21/93 - 22%)

- Routing
  - ✅ Get routes
  - ✅ Post routes
  - ✅ Routes with parameters
- Views
  - ⏳ HTML components
  - ⏳ HTML enum attributes
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
  - ⏳ Redirect responses
  - ⏳ Streamed response
  - ⏳ Keep-alive response
  - ⏳ Chunked transfer encoding
- Environment
  - Dot env embeded values ✅
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
    - ⏳ Local file
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
- Production running
  - ⏳ On-demand mode
  - ✅ Standalone mode (multi-cores)
- Testing
  - ✅ Expect test-style
  - ⏳ HTTP expectations
- Comparisons
  - ⏳ Laravel
  - ⏳ Rails
  - ⏳ AdonisJS
  - ⏳ Express
  - ⏳ Gin
- Examples
  - ⏳ With HTMX
  - ⏳ Inertia adapter
- ⏳ Exhaustive online documentation
