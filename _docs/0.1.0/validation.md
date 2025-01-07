# Validation

Mantis provides a validation system that helps ensure your data meets specific criteria.

## Basic Usage

Here's a simple example validating user input:

::: code-group

```v [main.v]
module main

import khalyomede.mantis.validation { validate, Rule, Value, Min }

fn main() {
  data := {
    "age": Value(21)
  }

  rules := {
    "age": [
      Rule(Min{18})
    ]
  }

  validate(data, rules) or {
    // err is a ValidationError
    eprintln(err.msg())

    exit(1)
  }

  println("The age is correct.")
}
```

:::

## Struct validation

You can get back a struct when validating data. Useful for form validation for example.

::: code-group

```v [main.v]
module main

import validation { validate_struct, Rule, Value, Min, Max }

struct ContactForm {
  email string
  message string
}

fn main() {
  email := "john.doe@example.com"
  message := "Tech companies 2024 survey."

  contact_form := validate_struct[ContactForm]({
    "email": Value(email)
    "message": Value(message)
  }, {
    "email": [
      Rule(Min{3})
    ]
    "message": [
      Rule(Min{3})
      Rule(Max{2000})
    ]
  }) or { panic(err) }

  assert contact_form.email == "john.doe@example.com"
  assert contact_form.message == "Tech companies 2024 survey."
}
```

:::

## Custom rules

You can create your own rules.

They must implement two method: `validate(Value) bool` and `message(string) string`.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.validation { Rule, Value }

// Custom email validation rule
struct Email {}

fn (rule Email) validate(value Value) bool {
  return match value {
    string {
      // Simple email check for demonstration
      value.contains('@') && value.contains('.')
    }
    else { false }
  }
}

fn (rule Email) message(key string) string {
  return "The ${key} must be a valid email address."
}

fn main() {
  email := "john.doe@company.com"

  data := {
    "email": Value(email)
  }

  rules := {
    "email": [
      Rule(Email{})
    ]
  }

  validation.validate(data, rules) or {
    eprintln(err.msg())

    exit(1)
  }

  println("The email is correct.")
}
```

:::

## Combining multiple rules

You can chain multiple rules for a field. The catched error will correspond to the first rule that did not pass.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.validation { validate, Rule, Value, Min, Max }

fn main() {
  post := {
    "title": Value("Structure and Interpretation of Computer Programs")
  }

  rules := {
    "title": [
      Rule(Min{5})
      Rule(Max{100})
    ]
  }

  validate(post, rules) or {
    eprintln(err.msg())

    exit(1)
  }

  println("The post data are correct.")
}
```

:::

## HTTP Form validation example

::: code-group

```v [main.v]
module main

import khalyomede.mantis.http { create_app, App, Response }
import khalyomede.mantis.http.route
import khalyomede.mantis.validation { Rule, Value, Min, Max } // [!code focus:22]

// Custom validation rule for passwords
struct StrongPassword {}

// 8 characters, with lower and uppercase
fn (rule StrongPassword) validate(value Value) bool {
  return match value {
    string {
      value.len >= 8 &&
      value.to_lower() != value &&
      value.to_upper() != value
    }
    else { false }
  }
}

fn (rule StrongPassword) message(key string) string {
  return "The ${key} must be at least 8 characters and contain both uppercase and lowercase letters."
}

fn main() {
  app := create_app(
    routes: [
      route.post(
        name: "register"
        path: "/register"
        callback: fn (app App) !Response {
          // Get form data
          email := app.request.form("email") or { "" }
          password := app.request.form("password") or { "" }

          // Define validation rules // [!code focus:14]
          rules := {
            "password": [
              Rule(StrongPassword{})
            ]
          }

          input := {
            "email": Value(email)
            "password": Value(password)
          }

          // Validate input
          validation.validate(input, rules)!

          // If we reach here, validation passed
          return app.response.html(
            content: "Registration successful!"
            status: .created
          )
        }
      )
    ]
  )

  app.serve() or { panic(err) }
}
```

:::

## Built-in Rules

- [Min](#min)
- [Max](#max)

### Min

Ensures the value has a minimum value.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.validation { validate, Rule, Value, Min }

fn main() {
  validate({
    "age": Value(21)
  }, {
    "age": [
      Rule(Min{18})
    ]
  }) or {
    eprintln(err.msg())

    exit(1)
  }

  println("Age is correct.")
}
```

:::

### Max

Ensures the value does not pass over the given value.

::: code-group

```v [main.v]
module main

import khalyomede.mantis.validation { validate, Rule, Value, Max }

fn main() {
  validate({
    "age": Value(31)
  }, {
    "age": [
      Rule(Max{100})
    ]
  }) or {
    eprintln(err.msg())
  }

  println("The age is correct.")
}
```

:::
