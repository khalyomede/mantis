module test

import regex

pub struct Expect[T] {
    pub:
        actual T
}

pub fn (expect Expect[T]) to_be_equal_to[U](expected U) {
    assert expected == expect.actual, "Expected \"${expected}\" to be = \"${expect.actual}\"."
}

pub fn (expect Expect[T]) to_be_different_than[U](expected U) {
    assert expected != expect.actual, "Expected \"${expected}\" to be ≠ \"${expect.actual}\"."
}

pub fn (expect Expect[T]) to_be_between[U](left U, right U) {
    assert left <= expect.actual && expect.actual <= right, "Expected ${expect.actual} to be between [${left}, ${right}]."
}

pub fn (expect Expect[bool]) to_be_true() {
    assert expect.actual == true, "Expected ${expect.actual} to be true."
}

pub fn (expect Expect[bool]) to_be_false() {
    assert expect.actual == false, "Expected ${expect.actual} to be false."
}

pub fn (expect Expect[T]) to_be_greater_than[U](expected U) {
    assert expect.actual > expected, "Expected ${expect.actual} to be > ${expected}."
}

pub fn (expect Expect[T]) to_be_greater_or_equal_to[U](expected U) {
    assert expect.actual >= expected, "Expected ${expect.actual} to be ≥ ${expected}."
}

pub fn (expect Expect[T]) to_be_lower_than[U](expected U) {
    assert expect.actual < expected, "Expected ${expect.actual} to be < ${expected}."
}

pub fn (expect Expect[T]) to_be_lower_or_equal_to[U](expected U) {
    assert expect.actual <= expected, "Expected ${expect.actual} to be ≤ ${expected}."
}

pub fn (expect Expect[string]) to_end_with(expected string) {
    assert expect.actual.ends_with(expected), "Expected \"${expect.actual}\" to end with \"${expected}\"."
}

pub fn (expect Expect[string]) to_not_end_with(expected string) {
    assert !expect.actual.ends_with(expected), "Expected \"${expect.actual} to not end with \"${expected}\"."
}

pub fn (expect Expect[string]) to_be_snake_case() {
    regular_expression := regex.regex_opt(r"^[a-z_]+$") or {
        panic(err)
    }

    assert regular_expression.matches_string(expect.actual), "Expected \"${expect.actual}\" to snake_case."
}

pub fn (expect Expect[string]) to_not_be_snake_case() {
    regular_expression := regex.regex_opt(r"^[a-z_]+$") or {
        panic(err)
    }

    assert !regular_expression.matches_string(expect.actual), "Expected \"${expect.actual}\" to not be snake_case."
}

pub fn (expect Expect[string]) to_be_kebab_case() {
    regular_expression := regex.regex_opt(r"^[a-z\-]+$") or {
        panic(err)
    }

    assert regular_expression.matches_string(expect.actual), "Expected \"${expect.actual}\" to be kebab-case."
}

pub fn (expect Expect[string]) to_not_be_kebab_case() {
    regular_expression := regex.regex_opt(r"^[a-z\-]+$") or {
        panic(err)
    }

    assert !regular_expression.matches_string(expect.actual), "Expected \"${expect.actual}\" to not be kebab-case."
}

pub fn (expect Expect[T]) to_have_key_equal_to[U, V](expected_key U, expected_value V) {
    actual_value := expect.actual[expected_key] or {
        assert false, "Expected map to contain key ${expected_key}."

        return
    }

    assert actual_value == expected_value, "Expected map key \"${expected_key}\" with value ${actual_value} to be = \"${expected_value}\"."
}

pub fn (expect Expect[[]string]) to_contain(expected string) {
    assert expect.actual.contains(expected), "Expected array ${expect.actual} to contain \"${expected}\"."
}

pub fn (expect Expect[[]string]) to_not_contain(expected string) {
    assert !expect.actual.contains(expected), "Expected array ${expect.actual} to not contain \"${expected}\"."
}

pub fn (expect Expect[string]) to_not_be_empty() {
    assert expect.actual.trim_space().len > 0
}

pub fn (expect Expect[string]) to_have_length(length int) {
    assert expect.actual.len == length, "Expected \"${expect.actual}\" to have length = ${length} (actual length = ${expect.actual.len})."
}

pub fn (expect Expect[i64]) to_be_negative() {
    assert expect.actual < i64(0), "Expected ${expect.actual} to be < 0."
}
