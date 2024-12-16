# Logging

Mantis provides structured logging utilities through its console module, allowing you to output messages with different severity levels.

## Basic Usage

Use the console functions to output messages with appropriate severity levels:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { info, error, debug }

fn main() {
  // Information messages
  info("Server starting on port 8080")

  // Error messages
  error("Failed to connect to database")

  // Debug messages
  debug("Request payload: {\"name\": \"John\"}")
}
```

:::

Each message is automatically formatted with:

- Timestamp in RFC3339 format
- Severity level indicator
- Your message

For example:

```bash
2024-12-16T10:30:45.123Z [INFO] Server starting on port 8080
```

## Severity Levels

The console module provides different severity levels to categorize your messages:

- DEBUG: Detailed information for debugging
- INFO: General information about system operation
- NOTICE: Significant but normal conditions
- WARNING: Warning messages for potentially problematic situations
- ERROR: Error conditions
- CRITICAL: Critical conditions requiring immediate attention
- ALERT: Action must be taken immediately
- EMERGENCY: System is unusable

Example using different severity levels:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.console { debug, info, error }

fn main() {
  // Debug level - detailed information
  debug("Processing request payload")

  // Info level - general information
  info("User logged in successfully")

  // Error level - error conditions
  error("Database connection failed")
}
```

:::
