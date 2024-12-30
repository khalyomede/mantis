module http

import test { expect }

fn test_method_get_to_string_return_as_expected() {
    expect(Method.get.to_string()).to_be_equal_to("GET")
}

fn test_method_head_to_string_return_as_expected() {
    expect(Method.head.to_string()).to_be_equal_to("HEAD")
}

fn test_method_post_to_string_return_as_expected() {
    expect(Method.post.to_string()).to_be_equal_to("POST")
}

fn test_method_put_to_string_return_as_expected() {
    expect(Method.put.to_string()).to_be_equal_to("PUT")
}

fn test_method_delete_to_string_return_as_expected() {
    expect(Method.delete.to_string()).to_be_equal_to("DELETE")
}

fn test_method_connect_to_string_return_as_expected() {
    expect(Method.connect.to_string()).to_be_equal_to("CONNECT")
}

fn test_method_options_to_string_return_as_expected() {
    expect(Method.options.to_string()).to_be_equal_to("OPTIONS")
}

fn test_method_trace_to_string_return_as_expected() {
    expect(Method.trace.to_string()).to_be_equal_to("TRACE")
}

fn test_method_patch_to_string_return_as_expected() {
    expect(Method.patch.to_string()).to_be_equal_to("PATCH")
}