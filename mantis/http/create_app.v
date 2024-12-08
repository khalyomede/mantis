module http

pub fn create_app(parameters App) App {
    return App{
        ...parameters
    }
}
