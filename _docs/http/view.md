# Views

Mantis provides a type-safe approach to building HTML views using V functions.

## Basic Views

Create HTML views using Mantis's HTML utilities:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { html, head, title, body, div, p } // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          content := html({}, [ // [!code focus:10]
            head({}, [
              title({}, ['Welcome'])
            ]),
            body({}, [
              div({}, [
                p({}, ['Hello world'])
              ])
            ])
          ])

          return response.html(content: content)
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Components

Break down your views into reusable components:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { div, nav, a } // [!code focus]

fn navbar() string { // [!code focus:7]
  return nav({}, [
    a({'href': '/'}, ['Home']),
    a({'href': '/about'}, ['About']),
    a({'href': '/contact'}, ['Contact'])
  ])
}

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          content := div({}, [ // [!code focus:4]
            navbar(),
            div({}, ['Page content'])
          ])

          return response.html(content: content)
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Attributes

Add HTML attributes to elements:

::: code-group

```v [main.v]
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { div, button } // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          content := div({ // [!code focus:10]
            'class': 'container'
          }, [
            button({
              'class': 'btn btn-primary'
              'type': 'submit'
            }, [
              'Click me'
            ])
          ])

          return response.html(content: content)
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Lists

Iterate over data to generate lists:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { ul, li } // [!code focus]

fn main() {
  app := create_app(
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          items := ['One', 'Two', 'Three'] // [!code focus:7]

          list_items := items.map(fn (item string) string {
            return li({}, [item])
          })

          content := ul({}, list_items)

          return response.html(content: content)
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
