module css

pub fn style(blocks []StyleBlock) string {
    mut stylesheet := []string{}

    for block in blocks {
        stylesheet << match block {
            Selector {
                block.to_string()
            }

            else {
                ""
            }
        }
    }

    return stylesheet.join("")
}
