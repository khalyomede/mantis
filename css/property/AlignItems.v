module property

pub enum AlignItems {
    anchor_center
    baseline
    center
    end
    first_baseline
    flex_end
    flex_start
    inherit
    initial
    last_baseline
    normal
    revert
    revert_layer
    safe_center
    self_end
    self_start
    start
    stretch
    unsafe_center
    unset
}

pub fn (align_items AlignItems) to_string() string {
    return match align_items {
        .anchor_center { "anchor-center" }
        .baseline { "baseline" }
        .center { "center" }
        .end { "end" }
        .first_baseline { "first baseline" }
        .flex_end { "flex-end" }
        .flex_start { "flex-start" }
        .inherit { "inherit" }
        .initial { "initial" }
        .last_baseline { "last baseline" }
        .normal { "normal" }
        .revert { "revert" }
        .revert_layer { "revert-layer" }
        .safe_center { "safe center" }
        .self_end { "self-end" }
        .self_start { "self-start" }
        .start { "start" }
        .stretch { "stretch" }
        .unsafe_center { "unsafe center" }
        .unset { "unset" }
    }
}
