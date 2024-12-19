module http

pub struct SessionData {
    pub:
        expires_at i64
        data map[string]string
}
