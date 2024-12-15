# Environment

Mantis provides type-safe environment variable handling through its `env` module.

## Basic Usage

Create a new environment instance by loading a `.env` file:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.env { Env }

fn main() {
  mut environment := Env{
    file: $embed_file('.env')  // Embeds the file at compile time
  }

  app_name := environment.get('APP_NAME') or { 'My App' }

  println(app_name)
}
```

:::

## Loading Environment Files

The environment file follows the standard format:

::: code-group

```dotenv [.env]
APP_NAME="My Application"
DB_HOST=localhost
DB_PORT=5432

# Comments are supported
AUTH_ENABLED=true
```

:::

## Reading Values

Use the `get()` method to read values. It returns an Option type, allowing safe handling of missing values:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.env { Env }

fn main() {
  mut environment := Env{
    file: $embed_file('.env')
  }

  // Provide a default value if the key doesn't exist
  db_host := environment.get('DB_HOST') or { 'localhost' }

  // Handle missing values explicitly
  if port := environment.get('DB_PORT') {
    println('Port configured: ${port}')
  } else {
    println('No port configured')
  }
}
```

:::

## Caching

For performance, Mantis automatically caches environment values after the first read. This means subsequent reads of the same key are retrieved from memory rather than parsing the file again:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.env { Env }

fn main() {
  mut environment := Env{
    file: $embed_file('.env')
  }

  // First read parses the file
  app_name := environment.get('APP_NAME') or { '' }

  // Second read uses cached value
  name := environment.get('APP_NAME') or { '' }
}
```
