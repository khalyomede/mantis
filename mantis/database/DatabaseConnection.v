module database

pub struct DatabaseConnection {
    pub:
        by_default bool
        driver DatabaseDriver
        database string
}
