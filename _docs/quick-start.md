# Quick start

Learn how to run an hello world app in a few minutes.

## Docker Compose

Install [Docker Compose](https://docs.docker.com/compose/install/).

Ensure it is running on a new terminal:

```bash
docker compose version
```

## V executable

Create a file "docker-compose.yml" and paste this content:

::: code-group

```yml [docker-compose.yml]
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

:::

Ensure V is runnable:

```bash
docker compose run --rm v --version
```

## V package installation

Install Mantis:

```bash
docker compose run --rm v install khalyomede.mantis
```

## Create the web server

In a file called `main.v` at the root, add this content:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response

fn main() {
  app := create_app(
    routes: [
      route.get(path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      })
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Run the server

Run this command:

```bash
docker compose run --rm --service-ports v watch run main.v
```

Your app is running at [http://localhost](http://localhost) or [http://127.0.0.1](http://127.0.0.1)
