import test { expect }
import http { Method }
fn test_method_get_to_string_return_as_expected() {
    expect(Method.get.to_string()).to_be_equal_to("GET")
}

