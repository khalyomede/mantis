module http

pub fn encode_url(raw string) string {
    mut result := []u8{cap: raw.len * 3} // Worst case: all chars need encoding (3 bytes each)

    for c in raw.bytes() {
        if is_unreserved(c) {
            result << c
        } else if c == ` ` {
            result << `+`
        } else {
            // Convert to %XX format
            result << `%`
            result << hex_digit(c >> 4)
            result << hex_digit(c & 0xF)
        }
    }

    return result.bytestr()
}

fn is_unreserved(c u8) bool {
    return match c {
        `A`...`Z` { true }
        `a`...`z` { true }
        `0`...`9` { true }
        `-`, `_`, `.`, `~` { true }
        else { false }
    }
}

fn hex_digit(n u8) u8 {
    if n < 10 {
        return u8(`0` + n)
    }
    return u8(`A` + (n - 10))
}
