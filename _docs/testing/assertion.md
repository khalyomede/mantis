# Assertion

Mantis provides an expressive testing utility that makes it easy to write clear and maintainable tests.

## Basic Assertions

The `expect` function allows you to write assertions in a natural, fluent style:

::: code-group

```v [tests/example_test.v]
import khalyomede.mantis.test { expect }

fn test_basic_assertions() {
  // Equality
  expect(1).to_be_equal_to(1)

  // Inequality
  expect(1).to_be_different_than(2)

  // Boolean assertions
  expect(true).to_be_true()
  expect(false).to_be_false()
}
```

:::

## Running tests

Run this command to run all assertions:

```bash
v -stats -N -W test .
```

To run tests from a specific file:

```bash
v -stats -N -W test tests/controllers/posts/store_test.v
```

## Tips for good tests

Here are some tips for writing effective tests with Mantis's testing utilities:

- Use descriptive test function names that explain the behavior being tested
- Keep tests focused on a single piece of functionality
- Follow the Arrange-Act-Assert pattern
- Use meaningful assertion messages

Example of a well-structured test:

::: code-group

```v [tests/controllers/index_test.v]
import khalyomede.mantis.html { create_app, App, Response, Request }
import khalyomede.mantis.html.response
import khalyomede.mantis.html.route
import khalyomede.mantis.test { expect }

fn test_home_page_displays_hello_world() {
  // 1. Arrange
  app := create_app(
    routes: [
      route.get(name: "index", path: "/", callback: fn (app App) Response {
        return response.html(content: "hello world")
      })
    ],
    request: Request{
      path: "/"
      method: .get
    }
  )

  // 2. Act
  res := app.render()

  // 3. Assert
  expect(res.content).to_be_equal_to("hello world")
}
```

:::

## Available assertions

- [to_be_equal_to](#to-be-equal-to)
- [to_be_different_than](#to-be-different-than)
- [to_be_between](#to-be-between)
- [to_be_greater_than](#to-be-greater-than)
- [to_be_greater_or_equal_to](#to-be-greater-or-equal-to)
- [to_be_lower_than](#to-be-lower-than)
- [to_be_lower_or_equal_to](#to-be-lower-or-equal-to)
- [to_be_true](#to-be-true)
- [to_be_false](#to-be-false)
- [to_end_with](#to-end-with)
- [to_not_end_with](#to-not-end-with)
- [to_be_snake_case](#to-be-snake-case)
- [to_not_be_snake_case](#to-not-be-snake-case)
- [to_be_kebab_case](#to-be-kebab-case)
- [to_not_be_kebab_case](#to-not-be-kebab-case)
- [to_have_key_equal_to](#to-have-key-equal-to)
- [to_contain](#to-contain)

### to_be_equal_to

Asserts that a value equals another value. Works with basic types like numbers, strings, and booleans.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_equality() {
  expect(42).to_be_equal_to(42)
  expect("hello").to_be_equal_to("hello")
  expect(true).to_be_equal_to(true)
}
```

:::

### to_be_different_than

Asserts that a value is different than another value.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_inequality() {
  expect(42).to_be_different_than(24)
  expect("hello").to_be_different_than("world")
  expect(true).to_be_different_than(false)
}
```

:::

### to_be_between

Asserts that a number falls between two other numbers (inclusive).

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_between() {
  expect(5).to_be_between(0, 10)
  expect(0).to_be_between(0, 10) // Inclusive lower bound
  expect(10).to_be_between(0, 10) // Inclusive upper bound
}
```

:::

### to_be_greater_than

Asserts that a number is greater than another number.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_greater_than() {
  expect(42).to_be_greater_than(41)
  expect(0).to_be_greater_than(-1)
}
```

:::

### to_be_greater_or_equal_to

Asserts that a number is greater than or equal to another number.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_greater_or_equal() {
  expect(42).to_be_greater_or_equal_to(42)
  expect(42).to_be_greater_or_equal_to(41)
}
```

:::

### to_be_lower_than

Asserts that a number is lower than another number.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_lower_than() {
  expect(41).to_be_lower_than(42)
  expect(-1).to_be_lower_than(0)
}
```

:::

### to_be_lower_or_equal_to

Asserts that a number is lower than or equal to another number.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_lower_or_equal() {
  expect(42).to_be_lower_or_equal_to(42)
  expect(41).to_be_lower_or_equal_to(42)
}
```

:::

### to_be_true

Asserts that a boolean value is true.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_is_true() {
  has_permission := true
  expect(has_permission).to_be_true()
}
```

:::

### to_be_false

Asserts that a boolean value is false.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_is_false() {
  is_deleted := false
  expect(is_deleted).to_be_false()
}
```

:::

### to_end_with

Asserts that a string ends with a given suffix.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_string_ending() {
  expect("hello world").to_end_with("world")
  expect("test.txt").to_end_with(".txt")
}
```

:::

### to_not_end_with

Asserts that a string does not end with a given suffix.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_string_not_ending() {
  expect("hello world").to_not_end_with("hello")
  expect("test.txt").to_not_end_with(".pdf")
}
```

:::

### to_be_snake_case

Asserts that a string follows snake_case convention.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_snake_case() {
  expect("user_name").to_be_snake_case()
  expect("first_last_name").to_be_snake_case()
}
```

:::

### to_not_be_snake_case

Asserts that a string does not follow snake_case convention.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_not_snake_case() {
  expect("userName").to_not_be_snake_case()
  expect("FirstLastName").to_not_be_snake_case()
}
```

:::

### to_be_kebab_case

Asserts that a string follows kebab-case convention.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_kebab_case() {
  expect("user-name").to_be_kebab_case()
  expect("first-last-name").to_be_kebab_case()
}
```

:::

### to_not_be_kebab_case

Asserts that a string does not follow kebab-case convention.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_not_kebab_case() {
  expect("userName").to_not_be_kebab_case()
  expect("first_last_name").to_not_be_kebab_case()
}
```

:::

### to_have_key_equal_to

Asserts that a map contains a specific key with an expected value.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_map_key_value() {
  user := {
    "name": "John"
    "age": "30"
  }

  expect(user).to_have_key_equal_to("name", "John")
}
```

:::

### to_contain

Asserts that an array contains a specific element.

::: code-group

```v [tests/example_test.v]
mantis.test { expect }

fn test_array_contains() {
  fruits := ["apple", "banana", "orange"]
  expect(fruits).to_contain("banana")
}
```

:::
