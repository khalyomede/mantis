import property { AlignItems }
import test { expect }

fn test_it_render_align_items_anchor_center_to_string() {
    expect(AlignItems.anchor_center.to_string()).to_be_equal_to("anchor-center")
}

fn test_it_render_align_items_baseline_to_string() {
    expect(AlignItems.baseline.to_string()).to_be_equal_to("baseline")
}

fn test_it_render_align_items_center_to_string() {
    expect(AlignItems.center.to_string()).to_be_equal_to("center")
}

fn test_it_render_align_items_end_to_string() {
    expect(AlignItems.end.to_string()).to_be_equal_to("end")
}

fn test_it_render_align_items_first_baseline_to_string() {
    expect(AlignItems.first_baseline.to_string()).to_be_equal_to("first baseline")
}

fn test_it_render_align_items_flex_end_to_string() {
    expect(AlignItems.flex_end.to_string()).to_be_equal_to("flex-end")
}

fn test_it_render_align_items_flex_start_to_string() {
    expect(AlignItems.flex_start.to_string()).to_be_equal_to("flex-start")
}

fn test_it_render_align_items_inherit_to_string() {
    expect(AlignItems.inherit.to_string()).to_be_equal_to("inherit")
}

fn test_it_render_align_items_initial_to_string() {
    expect(AlignItems.initial.to_string()).to_be_equal_to("initial")
}

fn test_it_render_align_items_last_baseline_to_string() {
    expect(AlignItems.last_baseline.to_string()).to_be_equal_to("last baseline")
}

fn test_it_render_align_items_normal_to_string() {
    expect(AlignItems.normal.to_string()).to_be_equal_to("normal")
}

fn test_it_render_align_items_revert_to_string() {
    expect(AlignItems.revert.to_string()).to_be_equal_to("revert")
}

fn test_it_render_align_items_revert_layer_to_string() {
    expect(AlignItems.revert_layer.to_string()).to_be_equal_to("revert-layer")
}

fn test_it_render_align_items_safe_center_to_string() {
    expect(AlignItems.safe_center.to_string()).to_be_equal_to("safe center")
}

fn test_it_render_align_items_self_end_to_string() {
    expect(AlignItems.self_end.to_string()).to_be_equal_to("self-end")
}

fn test_it_render_align_items_self_start_to_string() {
    expect(AlignItems.self_start.to_string()).to_be_equal_to("self-start")
}

fn test_it_render_align_items_start_to_string() {
    expect(AlignItems.start.to_string()).to_be_equal_to("start")
}

fn test_it_render_align_items_stretch_to_string() {
    expect(AlignItems.stretch.to_string()).to_be_equal_to("stretch")
}

fn test_it_render_align_items_unsafe_center_to_string() {
    expect(AlignItems.unsafe_center.to_string()).to_be_equal_to("unsafe center")
}

fn test_it_render_align_items_unset_to_string() {
    expect(AlignItems.unset.to_string()).to_be_equal_to("unset")
}

