# Fake data

## Basic usage

You can generate fake data, like person names, random integers, ... Useful for tests.

::: code-group

```v{4,6,9} [main_test.v]
import khalyomede.mantis.http { create_app, App, Response, Request, Status }
import khalyomede.mantis.http.response
import khalyomede.mantis.http.route
import khalyomede.mantis.test { expect, Fake }

const fake := Fake{}

fn test_it_returns_200_for_home_page() {
  content := fake.sentence()

  app := create_app(
    routes: [
      route.get(path: "/", callback: fn [content] (app App) Response {
        return response.html(content: content)
      })
    ]
    request: Request{
      method: .get
      path: "/"
    }
  )

  res := app.render()

  expect(res.status).to_be_equal_to(Status.ok)
  expect(res.content).to_be_equal_to(content)
}
```

:::

## Custom data

The `Fake` struct data are called "generators". See the [available generators](#available-generators) section for a complete list.

You can create your own like this.

::: code-group

```v{11} [main_test.v]
import khalyomede.mantis.test { expect }
import rand

struct Payment {}

fn (payment Payment) status() string {
  return rand.element(["pending", "validated", "rejected", "cancelled"]) or { "pending" }
}

struct Fake {
  test.Fake
  payment Payment
}

const fake := Fake{}

fn test_it_can_generate_payment_status() {
  status := fake.payment.status()

  expect(status).to_not_be_empty()
}
```

:::

## Available generators

- [Company name](#company-name)
- [Country code alpha 2](#country-code-alpha-2)
- [Country code alpha 3](#country-code-alpha-3)
- [Database primary key](#database-primary-key)
- [Email](#email)
- [Integer between](#integer-between)
- [Internet domain](#internet-domain)
- [Internet top level domain](#internet-top-level-domain)
- [Internet port](#internet-port)
- [Lang](#lang)
- [Negative integer](#negative-integer)
- [Person first name](#person-first-name)
- [Person last name](#person-last-name)
- [Person name](#person-name)
- [Sentence](#sentence)
- [UUID v4](#uuid-v4)
- [Word](#word)

### Company name

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  company_name := fake.company.name() // "Google"
}
```

:::

### Country code alpha 2

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  code := fake.country.code.alpha2() // "us"
}
```

:::

### Country code alpha 2

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  code := fake.country.code.alpha3() // "usa"
}
```

:::

### Database primary key

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  key := fake.database.primary_key() // "129"
}
```

:::

### Email

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  email := fake.email() // "john.doe@example.com"
}
```

:::

### Integer between

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  number := fake.integer.between(1, 20) // 12
}
```

:::

### Internet domain

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  domain := fake.internet.domain() // "example"
}
```

:::

### Internet top level domain

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  tld := fake.internet.top_level_domain() // "com"
}
```

:::

### Internet port

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  port := fake.internet.port() // 3306
}
```

:::

### Lang

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  lang := fake.lang() // "en"
}
```

:::

### Negative integer

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  number := fake.negative_integer() // -125
}
```

:::

### Person first name

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  name := fake.person.first_name() // "John"
}
```

:::

### Person last name

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  name := fake.person.last_name() // "Doe"
}
```

:::

### Person name

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  name := fake.person.name() // "John Doe"
}
```

:::

### Sentence

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  sentence := fake.sentence() // "The meeting has been rescheduled."
}
```

:::

### UUID v4

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  uuid := fake.uuid.v4() // "4c9c5f06-ea31-4548-a200-82ab7fe14017"
}
```

:::

### Word

::: code-group

```v [main.v]
module main

import khalyomede.mantis.test { Fake }

fn main() {
  fake := Fake{}

  uuid := fake.word() // "eloquent"
}
```

:::
