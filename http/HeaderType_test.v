import http { HeaderType }
import test { expect }

fn test_it_renders_header_type_accept_to_string() {
    expect(HeaderType.accept.to_string()).to_be_equal_to("Accept")
}

fn test_it_renders_header_type_content_type_to_string() {
    expect(HeaderType.content_type.to_string()).to_be_equal_to("Content-Type")
}

fn test_it_renders_header_type_location_to_string() {
    expect(HeaderType.location.to_string()).to_be_equal_to("Location")
}
