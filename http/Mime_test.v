import http
import test { expect }

fn test_it_can_render_mime_application_json_to_string() {
    expect(http.Mime.application_json.to_string()).to_be_equal_to("application/json")
}

fn test_it_can_render_mime_text_html_to_string() {
    expect(http.Mime.text_html.to_string()).to_be_equal_to("text/html")
}
