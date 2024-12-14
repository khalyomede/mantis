# Views

Mantis provides a type-safe approach to building HTML views using V functions.

## Basic Views

Create HTML views using Mantis's HTML utilities:

```v
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { html, head, title, body, div, p }

app := create_app(
  routes: [
    route.get(
      name: "index"
      path: "/"
      callback: fn (app App) Response {
        content := html({}, [
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
```

## Components

Break down your views into reusable components:

```v
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { div, nav, a }

fn navbar() string {
  return nav({}, [
    a({'href': '/'}, ['Home']),
    a({'href': '/about'}, ['About']),
    a({'href': '/contact'}, ['Contact'])
  ])
}

app := create_app(
  routes: [
    route.get(
      name: "index"
      path: "/"
      callback: fn (app App) Response {
        content := div({}, [
          navbar(),
          div({}, ['Page content'])
        ])

        return response.html(content: content)
      }
    )
  ]
)
```

## Attributes

Add HTML attributes to elements:

```v
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { div, button }

app := create_app(
  routes: [
    route.get(
      name: "index"
      path: "/"
      callback: fn (app App) Response {
        content := div({
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
```

## Lists

Iterate over data to generate lists:

```v
import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.html { ul, li }

app := create_app(
  routes: [
    route.get(
      name: "index"
      path: "/"
      callback: fn (app App) Response {
        items := ['One', 'Two', 'Three']

        list_items := items.map(fn (item string) string {
          return li({}, [item])
        })

        content := ul({}, list_items)

        return response.html(content: content)
      }
    )
  ]
)
```
