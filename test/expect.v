module test

pub fn expect[T](value T) Expect[T] {
    return Expect[T]{
        actual: value
    }
}
