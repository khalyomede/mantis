module http

pub struct HttpError {
    pub:
        code    Status
        message string
}

fn (err HttpError) msg() string {
    return err.message
}

fn (err HttpError) code() int {
    return err.code.to_int()
}
