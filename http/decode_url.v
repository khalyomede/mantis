module http

pub fn decode_url(encoded string) string {
    if encoded.len == 0 {
        return encoded
    }

    mut result := []u8{cap: encoded.len} // Result will be at most as long as input
    mut i := 0

    for i < encoded.len {
        c := encoded[i]

        if c == `+` {
            result << ` ` // Convert + to space
            i++
            continue
        }

        if c == `%` && i + 2 < encoded.len {
            // Try to parse next two chars as hex
            hex_str := encoded[i+1..i+3]
            byte_val := decode_hex_byte(hex_str) or {
                // If invalid hex, keep original %
                result << c
                i++
                continue
            }
            result << byte_val
            i += 3 // Skip the % and two hex digits
            continue
        }

        // Copy character as-is
        result << c
        i++
    }

    return result.bytestr()
}

fn decode_hex_byte(hex string) ?u8 {
    if hex.len != 2 {
        return none
    }

    high := decode_hex_digit(hex[0]) ?
    low := decode_hex_digit(hex[1]) ?

    return u8(high << 4 | low)
}

fn decode_hex_digit(c u8) ?int {
    return match c {
        `0`...`9` { int(c - `0`) }
        `a`...`f` { int(c - `a` + 10) }
        `A`...`F` { int(c - `A` + 10) }
        else { none }
    }
}
