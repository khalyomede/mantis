import validation { Min, Rule, Value }
import test { expect }

// Custom rule

struct Palindrome {}

pub fn (rule Palindrome) validate(value Value, opts []string) bool {
    return match value {
        string {
            unspaced := value.to_lower().replace(' ', '')

            unspaced == unspaced.reverse()
        }

        else { false }
    }
}

pub fn (rule Palindrome) message(value Value, key string, opts []string) string {
    return "The ${key} must read the same forwards and backwards."
}

struct User {
    age int @[validate: 'min:0']
}

struct Phrase {
    sentence string @[validate: 'palindrome']
}

// Tests

fn test_can_validate_number_must_be_greater_than_zero() {
    data := {
        "age": Value(31)
    }

    validator := validation.Validator.new()
    validated := validator.validate[User](data) or {
        panic(err)
    }

    expect(validated.age).to_be_equal_to(31)
}

fn test_can_return_validation_error_when_validating_number_greater_than_zero() {
    data := {
        "age": Value(-200)
    }

    validator := validation.Validator.new()
    validated := validator.validate[User](data) or {
        expect(err.str()).to_be_equal_to("The age must be greater than 0.")
        return
    }

    panic("unreachable: $validated")
}

fn test_can_validate_on_custom_rule() {
    data := {
        "sentence": Value("Never odd or even")
    }

    mut validator := validation.Validator.new()
    validator.add_rule("palindrome", Rule(Palindrome{}))

    validated := validator.validate[Phrase](data) or {
        panic("sentence: $err")
    }

    expect(validated.sentence).to_be_equal_to("Never odd or even")
}
