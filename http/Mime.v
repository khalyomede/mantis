module http

pub enum Mime {
    application_json
    text_html
}

pub fn (mime Mime) to_string() string {
    return match mime {
        .application_json { "application/json" }
        .text_html { "text/html" }
    }
}
