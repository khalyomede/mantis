module html

/**
 * @todo To refine, probably each[T](list T) string.
 * @todo Test all HTML utilities.
 */
pub fn each[T, V](list map[T]V, callback fn (key T, value V) string) string {
    mut content := []string{}

    for key, value in list {
        content << callback(key, value)
    }

    return content.join("")
}
