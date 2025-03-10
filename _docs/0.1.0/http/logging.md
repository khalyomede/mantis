# Logging

## File logging

You can log on a file:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.logging { Log } // [!code focus:2]
import khalyomede.mantis.logging.channel { File }

fn main() {
  app := create_app(
    log: Log{ // [!code focus:5]
      channel: File{
        path: "logs/mantis.log"
      }
    }
    routes: [
      route.post(name: "contact.store", path: "/contact", callback: fn (app App) !Response {
        app.log.debug("Contact form sent.")! // [!code focus]

        return app.response.redirect("/", {})
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

```log [logs/mantis.log]
2024-12-26T17:36:45.896350428Z] [DBUG] Contact form sent.
```

:::

Learn all the available method in the [Logging](/0.1.0/logging) documentation.
