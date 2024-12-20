# Laravel

[Laravel](https://laravel.com/) is an incredibly productive web framework written in [PHP](https://www.php.net/). If you seek for the fastest time-to-market, huge store of packages for real-world busineess use case and exceptional local-to-production experience, battle tested components and dead-simple deployment, [Laravel](https://laravel.com/) is the go-to choice for teams that want to ship fast.

## Hello world

Here is a simple hello world written on both [Laravel](https://laravel.com/) and Mantis.

::: code-group

```php [routes/web.php]
use Illuminate\Support\Facades\Route;

Route::get("/", function(): string {
  return "hello world";
})->name("index");
```

```v [main.v]
module main

import khalyomede.mantis.http { app_create, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Form validation

::: code-group

```php [routes/web.php]
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Routes;
use App\Models\Post;
use App\Http\Requests\Post\UpdateRequest;

Route::put("/post/{post}", function(UpdateRequest $request, Post $post): RedirectResponse {
  $validated = $request->validated();

  $post->update([
    "title" => $validated["title"],
    "excerpt" => $validated["excerpt"],
  ]);

  return redirect()->route("post.show", $post);
})->name("post.update");
```

```v [main.v]
module main

import khalyomede.mantis.database { Database, DatabaseConnection }
import khalyomede.mantis.http { app_create, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.validation { validate, Rule, Value }

struct Filled {}

fn (rule Filled) validate(value Value) bool {
  return match value {
    string {
      value.trim_space().len > 0
    }
    else { false }
  }
}

fn (rule Filled) message(key string) string {
  return "The ${key} must be a filled."
}

struct Post {
  id u64
  title string
  excerpt string
}

fn main() {
  app := create_app(
    database: Database{
      connection: DatabaseConnection{
        by_default: true
        driver: .sqlite
        database: 'database.sqlite'
    }
    routes: [
      route.get(name: "post.update", path: "/post/{post}", callback: fn (app App) Response {
        id := app.route_parameter("post") or {
          return response.html(status: .not_found)
        }

        posts := app.database.all[Post]("SELECT title, excerpt FROM posts WHERE id = ${id}") or {
          return response.html(status: .server_error)
        }

        post := posts[0] or {
          return response.html(status: .not_found)
        }

        title := app.request.form("title") or {
          return response.html(status: .unprocessable_entity)
        }

        excerpt := app.request.form("excerpt") or {
          return response.html(status: .unprocessable_entity)
        }

        data := {
          "title": Value(title)
          "excerpt": Value(excerpt)
        }

        rules := {
          "title": [
            Filled{}
          ]
          "excerpt": [
            Filled{}
          ]
        }

        validate(data, rules) or {
          return response.html(
            content: err.msg()
            status: .unprocessable_entity
          )
        }

        app.database.run("UPDATE posts SET title = ${title}, excerpt = ${excerpt} WHERE id = ${id}") or {
          return response.html(status: .server_error)
        }

        return response.redirect("/post/{$id}", {})
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
