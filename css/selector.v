module css

pub fn selector(value string, blocks []SelectorBlock) Selector {
    return Selector {
        selector: value
        blocks: blocks
    }
}
