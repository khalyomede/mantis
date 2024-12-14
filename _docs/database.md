# Database

Mantis provides type-safe database operations that map directly to V structs.

::: tip Notice
Mantis currently only supports SQLite databases.
:::

## Basic Usage

::: code-group

```v [main.v]
module main

import khalyomede.mantis.database { Database, DatabaseConnection, DatabaseDriver }

// Define your data structure
struct Post {
  id int
  title string
  views u64
}

fn main() {
  mut db := Database{
    connection: DatabaseConnection{
      by_default: true
      driver: .sqlite
      database: 'blog.db'
    }
  }

  defer {
    db.close() or { panic(err) }
  }

  // Query all records with type safety
  posts := db.all[Post]('SELECT id, title, views FROM posts') or {
    panic(err)
  }

  for post in posts {
    println('${post.title} (${post.views} views)')
  }
}
```

:::

## Running raw queries

Use run() for INSERT, UPDATE, DELETE operations:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.database { Database, DatabaseConnection }

fn main() {
  mut db := Database{
    connection: DatabaseConnection{
      by_default: true
      driver: .sqlite
      database: 'blog.db'
    }
  }

  // Create table
  db.run("
    CREATE TABLE IF NOT EXISTS posts (
      id INTEGER PRIMARY KEY,
      title TEXT,
      views INTEGER
    )
  ") or { panic(err) }

  // Insert data
  db.run("
    INSERT INTO posts (title, views)
    VALUES ('My First Post', 42)
  ") or {
    panic(err)
  }
}
```

:::
