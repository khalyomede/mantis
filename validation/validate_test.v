import validation { Min, Rule, Value }
import test { expect }

// Custom rule

struct Palindrome {}

pub fn (rule Palindrome) validate(value Value) bool {
    return match value {
        string {
            unspaced := value.to_lower().replace(' ', '')

            unspaced == unspaced.reverse()
        }

        else {
            false
        }
    }
}

pub fn (rule Palindrome) message(key string) string {
    return "The ${key} must read the same forwards and backwards."
}

// Tests

fn test_can_validate_number_must_be_greater_than_zero() {
    data := {
        "age": Value(31)
    }

    rules := {
        "age": [
            Rule(Min{0})
        ]
    }

    validated := validation.validate(data, rules) or {
        {"age": Value(err.msg())}
    }

    expect(validated["age"]).to_be_equal_to(Value(31))
}

fn test_can_return_validation_error_when_validating_number_greater_than_zero() {
    data := {
        "age": Value(-200)
    }

    rules := {
        "age": [
            Rule(Min{0})
        ]
    }

    validated := validation.validate(data, rules) or {
        {"age": Value(err.msg())}
    }

    expect(validated["age"] or { "" }).to_be_equal_to(Value("The age must be greater than 0."))
}

fn test_can_validate_on_custom_rule() {
    data := {
        "sentence": Value("Never odd or even")
    }

    rules := {
        "sentence": [
            Rule(Palindrome{})
        ]
    }

    validated := validation.validate(data, rules) or {
        {"sentence": Value(err.msg())}
    }

    expect(validated["sentence"] or { "" }).to_be_equal_to(Value("Never odd or even"))
}
