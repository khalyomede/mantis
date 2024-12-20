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

Ensure [V](https://vlang.io/) is runnable:

```bash
docker compose run --rm v --version
```

## Initialize your project

Run `docker compose run --rm v init` and follow the instructions.

## V package installation

### Package manager

::: warning
Due to a bug, [VPM](https://vpm.vlang.io/) is not able to receive new package submission. Please use the [manual installation](#manual-installation) in the mean time.
:::

Install Mantis using the included package manager:

```bash
docker compose run --rm v install khalyomede.mantis
```

### Manual installation

1. Go to https://github.com/khalyomede/mantis
2. On the green button "Code", click on "Download zip"
3. On your root folder, create the folder "khalyomede"
4. On the folder "khalyomede", create the folder "mantis"
5. Unzip your folder content into "mantis"

::: details Run this script in your root folder if you want to automatize this steps.

```bash
#!/bin/bash

# Check for required commands
for cmd in curl unzip; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed"
    exit 1
  fi
done

# Create the directory structure if it doesn't exist
mkdir -p khalyomede/mantis

# Download the zip file from GitHub (using -L to follow redirects)
curl -L https://github.com/khalyomede/mantis/archive/master.zip -o mantis.zip

# Unzip the content
unzip mantis.zip

# Move the contents from the created directory to our target directory
mv mantis-master/* khalyomede/mantis/

# Clean up temporary files and empty directory
rm -rf mantis.zip mantis-master

echo "Mantis has been installed successfully in khalyomede/mantis/"
```

:::

You should end up with the following folder tree:

```
your-folder
├── khalyomede
│   └── mantis
│       ├── _docs
│       ├── console
│       ├── css
│       ├── database
│       └── ...
├── docker-compose.yml
├── main.v
└── v.mod
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
