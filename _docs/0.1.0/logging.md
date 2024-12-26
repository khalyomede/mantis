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

  log.debug("Email sent.")
}
```

```log [logs/mantis.log]
[2024-12-26T17:31:05.147793327Z] [DBUG] Email sent.
```

:::

You can also manually set the severity:

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

  log.log(.error, "Database connection lost.") // [!code focus]
}
```

```log [logs/mantis.log]
[2024-12-26T17:41:19.933122161Z] [ERRO] Database connection lost.
```

:::
