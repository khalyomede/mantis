import mantis.test { expect }

fn test_can_assert_two_number_are_equal() {
    expect(1).to_be_equal_to(1)
}

fn test_can_assert_two_number_are_different() {
    expect(1).to_be_different_than(2)
}

fn test_can_assert_number_between_two_other_numbers() {
    expect(1).to_be_between(0, 1)
}

fn test_can_assert_value_is_true() {
    expect(true).to_be_true()
}

fn test_can_assert_number_is_greater_than_another() {
    expect(1).to_be_greater_than(0)
}

fn test_can_assert_number_is_greater_or_equal_than_another() {
    expect(1).to_be_greater_or_equal_to(1)
}

fn test_can_assert_number_is_lower_than_another() {
    expect(1).to_be_lower_than(2)
}

fn test_can_assert_number_is_lower_or_equal_to_another() {
    expect(1).to_be_lower_or_equal_to(1)
}

fn test_can_assert_text_ends_with_something() {
    expect("hello world").to_end_with("world")
}

fn test_can_assert_map_contains_value_in_key() {
    expect({"hello": "world"}).to_have_key_equal_to("hello", "world")
}
