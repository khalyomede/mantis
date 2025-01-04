/*
    This code should not be used.
    This is a save from an experiment to improve the DX of validation.
    It is not ready yet: the final signature will look like the current validation, with a map of data and a map of rules.
    The issue is when I iterate over a generic map, I get this C error: https://github.com/vlang/v/issues/23376.
    I will wait until this issue is resolved.
*/

module validation

struct RuleNext[T] {
  validate fn (value T) bool = fn [T](value T) bool {
    return true
  }

  error_message fn () string = fn () string {
    return ""
  }
}

struct MinimumInteger {
  value int
  message ?string
}

fn (rule MinimumInteger) validate(value int) bool {
  return value >= rule.value
}

fn (rule MinimumInteger) error_message() string {
  return rule.message or {
    "The value must be greater or equal to ${rule.value}."
  }
}

struct ValidationErrorNext {
  message string
  // TODO: have a []string of messages.
}

fn (error ValidationErrorNext) msg() string {
  return error.message
}

fn (error ValidationErrorNext) code() int {
  return 422
}

fn minimum_integer(rule MinimumInteger) RuleNext[int] {
  return RuleNext[int]{
    validate: rule.validate
    error_message: rule.error_message
  }
}

fn validate_next[T](values map[string]T, rules []RuleNext[T]) ! {
  for _, value in values {
    for rule in rules {
      if !rule.validate(value) {
        return ValidationErrorNext{rule.error_message()}
      }
    }
  }
}

// fn main() {
//   validate_next({"age": 31}, [
//     minimum_integer(value: 41)
//   ]) or {
//     eprintln(err.msg())
//   }
// }
