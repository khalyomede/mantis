import mantis.http { decode_url }
import mantis.test { expect }

fn test_decodes_plus_sign_to_space() {
    expect(decode_url('hello+world')).to_be_equal_to('hello world')
}

fn test_decodes_percent_20_to_space() {
    expect(decode_url('hello%20world')).to_be_equal_to('hello world')
}

fn test_decodes_percent_encoded_special_characters() {
    expect(decode_url('hello%21world')).to_be_equal_to('hello!world')
}

fn test_preserves_invalid_percent_encoding() {
    expect(decode_url('hello%2world')).to_be_equal_to('hello%2world')
}

fn test_preserves_invalid_hex_in_percent_encoding() {
    expect(decode_url('hello%GGworld')).to_be_equal_to('hello%GGworld')
}

fn test_handles_utf8_characters() {
    expect(decode_url('hello%C3%A9world')).to_be_equal_to('helloéworld')
}

fn test_handles_empty_string_decode() {
    expect(decode_url('')).to_be_equal_to('')
}
