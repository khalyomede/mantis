# Logging

## File logging

You can log on a given file.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.logging { Log }
import khalyomede.mantis.logging.channel { File }

fn main() {
  mut log := Log{
    channel: File{
      path: "logs/mantis.log"
    }
  }

  log.debug("Email sent.") or {
    panic(err)
  }
}
```

```log [logs/mantis.log]
[2024-12-26T17:31:05.147793327Z] [DBUG] Email sent.
```

:::

## Dynamic severity

You can choose the severity at runtime.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.logging { Log }
import khalyomede.mantis.logging.channel { File }

fn main() {
  mut log := Log{
    channel: File{
      path: "logs/mantis.log"
    }
  }

  log.log(.error, "Database connection lost.") or { // [!code focus]
    panic(err)
  }
}
```

```log [logs/mantis.log]
[2024-12-26T17:41:19.933122161Z] [ERRO] Database connection lost.
```

:::

## Available severities

::: code-group

```v [main.v]
module main

import khalyomede.mantis.logging { Log }
import khalyomede.mantis.logging.channel { File }

fn main() {
  log.emergency("System cannot serve response.") or { panic(err) } // [!code focus:8]
  log.alert("Disk space threshold reached.") or { panic(err) }
  log.critical("Request mitigation process does not respond.") or { panic(err) }
  log.error("Database connection lost.") or { panic(err) }
  log.warning("Cache key not found.") or { panic(err) }
  log.notice("Using in memory cache driver is not recommended in production.") or { panic(err) }
  log.info("Switching to fallback SMTP.") or { panic(err) }
  log.debug("Email sent.") or { panic(err) }
}
```

:::

You can also use the `log.log()` function to pass the severity at runtime.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.logging { Log }
import khalyomede.mantis.logging.channel { File }

fn main() {
  log.log(.emergency, "System cannot serve response.") or { panic(err) } // [!code focus:8]
  log.log(.alert, "Disk space threshold reached.") or { panic(err) }
  log.log(.critical, "Request mitigation process does not respond.") or { panic(err) }
  log.log(.error, "Database connection lost.") or { panic(err) }
  log.log(.warning, "Cache key not found.") or { panic(err) }
  log.log(.notice, "Using in memory cache driver is not recommended in production.") or { panic(err) }
  log.log(.info, "Switching to fallback SMTP.") or { panic(err) }
  log.log(.debug, "Email sent.") or { panic(err) }
}
```

## Default logger

By default the logger will simply log in console.

::: code-group

```v [main.v]
module main

import logging { Log }

fn main() {
  mut log := Log{}

  log.info("hey there!") or { panic(err) }
}
```
