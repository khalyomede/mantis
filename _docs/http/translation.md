# Translation

## Simple Text

Translate basic text strings:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.translation { Translation, Lang }

fn main() {
  app := create_app(
    translation: Translation{
      keys: {
        "Hello World": {
          .en: {
            .neutral: {
              .any: "Hello world"
            }
          }
          .fr: {
            .neutral: {
              .any: "Bonjour le monde"
            }
          }
        }
      }
    }
    routes: [
      route.get(
        name: "index"
        path: "/"
        callback: fn (app App) Response {
          text := app.translation.translate(key: "Hello World", lang: .fr)
          return response.html(content: text)  // "Bonjour le monde"
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Parameters

Include dynamic values in translations:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.translation { Translation, Lang }

fn main() {
  app := create_app(
    translation: Translation{
      keys: {
        "Welcome {name}": {
          .en: {
            .neutral: {
              .any: "Welcome {name}"
            }
          }
          .fr: {
            .neutral: {
              .any: "Bienvenue {name}"
            }
          }
        }
      }
    }
    routes: [
      route.get(
        name: "welcome"
        path: "/welcome"
        callback: fn (app App) Response {
          text := app.translation.translate(
            key: "Welcome {name}",
            lang: .fr,
            parameters: {
              "name": "John"
            }
          )
          return response.html(content: text)  // "Bienvenue John"
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Pluralization

Handle singular/plural forms:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.translation { Translation, Lang }

fn main() {
  app := create_app(
    translation: Translation{
      keys: {
        "You have {count} messages": {
          .en: {
            .neutral: {
              .zero: "You have no messages"
              .one: "You have one message"
              .many: "You have {count} messages"
            }
          }
          .fr: {
            .neutral: {
              .zero: "Vous n'avez pas de messages"
              .one: "Vous avez un message"
              .many: "Vous avez {count} messages"
            }
          }
        }
      }
    }
    routes: [
      route.get(
        name: "messages"
        path: "/messages"
        callback: fn (app App) Response {
          text := app.translation.translate(
            key: "You have {count} messages",
            lang: .fr,
            count: 3
          )
          return response.html(content: text)  // "Vous avez 3 messages"
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Gender

Handle gender-specific translations:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.http.response
import khalyomede.mantis.translation { Translation, Lang }

fn main() {
  app := create_app(
    translation: Translation{
      keys: {
        "{name} updated their profile": {
          .en: {
            .masculine: {
              .any: "{name} updated his profile"
            }
            .feminine: {
              .any: "{name} updated her profile"
            }
          }
          .fr: {
            .masculine: {
              .any: "{name} a mis à jour son profil"
            }
            .feminine: {
              .any: "{name} a mise à jour son profil"
            }
          }
        }
      }
    }
    routes: [
      route.get(
        name: "profile.updated"
        path: "/profile/updated"
        callback: fn (app App) Response {
          text := app.translation.translate(
            key: "{name} updated their profile",
            lang: .fr,
            gender: .feminine,
            parameters: {
              "name": "Marie"
            }
          )
          return response.html(content: text)  // "Marie a mise à jour son profil"
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::
