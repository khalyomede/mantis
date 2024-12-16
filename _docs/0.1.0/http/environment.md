# Environment Variables

Learn how to use environment variables in your HTTP application.

## Configuration

Configure environment variables in your HTTP App:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.env { Env } // [!code focus]

fn main() {
  app := create_app(
    env: Env{ // [!code focus:3]
      file: $embed_file('.env')
    }
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          return response.html(content: "hello world")
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Reading Variables

Access environment variables in your route callbacks:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.env { Env } // [!code focus]

fn main() {
  app := create_app(
    env: Env{ // ![code focus:3]
      file: $embed_file('.env')
    }
    routes: [
      route.get(
        name: "status.index"
        path: "/status"
        callback: fn (app App) Response {
          mut instance := app

          app_name := instance.env.get('APP_NAME') or { 'My App' } // [!code focus:4]
          app_mode := instance.env.get('APP_MODE') or { 'development' }

          return response.html(content: '${app_name} running in ${app_mode} mode')
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Environment File

Your .env file can contain various configuration options:

::: code-group

```dotenv [.env]
APP_NAME=My Application
APP_MODE=development

DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp
DB_USER=admin
DB_PASSWORD=secret

MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=username
MAIL_PASSWORD=password

# Add comments for clarity
CACHE_DRIVER=redis  # Supported: "redis", "memcached"
```

:::

## Default Values

Handle missing environment variables gracefully using V's Option type:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.env { Env } // [!code focus]

fn main() {
  app := create_app(
    env: Env{ // [!code focus:3]
      file: $embed_file('.env')
    }
    routes: [
      route.get(
        name: "config.index"
        path: "/config"
        callback: fn (app App) Response {
          mut instance := app

          // Provide defaults for missing values // [!code focus:8]
          config := {
            'name': instance.env.get('APP_NAME') or { 'My App' }
            'mode': instance.env.get('APP_MODE') or { 'development' }
            'port': instance.env.get('APP_PORT') or { '8080' }
            'debug': instance.env.get('APP_DEBUG') or { 'false' }
          }

          return response.html(content: 'Configuration loaded')
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
