import validation { Min, Rule, Value }
import test { expect, Fake }

// Custom rule

struct Palindrome {}
struct User { age int }

const fake := Fake{}

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
    age := fake.integer.between(1, 99)

    data := {
        "age": Value(age)
    }

    rules := {
        "age": [
            Rule(Min{0})
        ]
    }

    validated := validation.validate(data, rules) or {
        {"age": Value(err.msg())}
    }

    expect(validated).to_have_key_equal_to("age", Value(age))
}

fn test_can_return_validation_error_when_validating_number_greater_than_zero() {
    data := {
        "age": Value(fake.negative_integer())
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

fn test_can_validate_structs() {
    age := int(fake.integer.between(1, 99))

    data := {
        "age": Value(age)
    }

    rules := {
        "age": [
            Rule(Min{0})
        ]
    }

    validated := validation.validate_struct[User](data, rules) or {
        panic(err)
    }

    expect(validated.age).to_be_equal_to(age)
}
