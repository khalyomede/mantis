import http { encode_url }
import test { expect }

fn test_encodes_space_to_plus() {
    expect(encode_url('hello world')).to_be_equal_to('hello+world')
}

fn test_preserves_unreserved_characters() {
    expect(encode_url('hello-world_123.~')).to_be_equal_to('hello-world_123.~')
}

fn test_encodes_special_characters() {
    expect(encode_url('hello!world')).to_be_equal_to('hello%21world')
}

fn test_encodes_utf8_characters() {
    expect(encode_url('helloéworld')).to_be_equal_to('hello%C3%A9world')
}

fn test_handles_empty_string_encode() {
    expect(encode_url('')).to_be_equal_to('')
}
