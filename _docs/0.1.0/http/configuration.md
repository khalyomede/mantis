# Configuration

Learn how to configure your HTTP server for optimal performance and security.

## Basic Configuration

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app }

fn main() {
  app := create_app( // [!code focus:6]
    host: "0.0.0.0" // Network interface to bind to
    port: 8080 // Port to listen on
    mode: .standalone // Server operation mode
    cpus: 8 // Number of CPU cores to use
  )

  app.serve() or { panic(err) }
}
```

:::

## Server Options

### Host

Controls which network interface the server binds to:

- "0.0.0.0" - Listen on all interfaces
- "127.0.0.1" - Listen only on localhost
- "192.168.1.10" - Listen on specific interface

### Port

The TCP port your server listens on (1-65535)

### CPU Cores

The cpus parameter controls how many worker processes handle requests:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app }

fn main() {
  app := create_app(
    cpus: 8  // Use 8 CPU cores // [!code focus]
  )

  app.serve() or { panic(err) }
}
```

:::

Best practices:

- Set to number of available CPU cores for maximum performance
- Leave 1-2 cores free for system processes on production servers
- For development, single core is usually sufficient
