import css.property { align_items }
import test { expect }

fn test_it_render_align_items_anchor_center_to_string() {
    expect(align_items(.anchor_center).to_string()).to_be_equal_to("align-items:anchor-center;")
}

fn test_it_render_align_items_baseline_to_string() {
    expect(align_items(.baseline).to_string()).to_be_equal_to("align-items:baseline;")
}

fn test_it_render_align_items_center_to_string() {
    expect(align_items(.center).to_string()).to_be_equal_to("align-items:center;")
}

fn test_it_render_align_items_end_to_string() {
    expect(align_items(.end).to_string()).to_be_equal_to("align-items:end;")
}

fn test_it_render_align_items_first_baseline_to_string() {
    expect(align_items(.first_baseline).to_string()).to_be_equal_to("align-items:first baseline;")
}

fn test_it_render_align_items_flex_end_to_string() {
    expect(align_items(.flex_end).to_string()).to_be_equal_to("align-items:flex-end;")
}

fn test_it_render_align_items_flex_start_to_string() {
    expect(align_items(.flex_start).to_string()).to_be_equal_to("align-items:flex-start;")
}

fn test_it_render_align_items_inherit_to_string() {
    expect(align_items(.inherit).to_string()).to_be_equal_to("align-items:inherit;")
}

fn test_it_render_align_items_initial_to_string() {
    expect(align_items(.initial).to_string()).to_be_equal_to("align-items:initial;")
}

fn test_it_render_align_items_last_baseline_to_string() {
    expect(align_items(.last_baseline).to_string()).to_be_equal_to("align-items:last baseline;")
}

fn test_it_render_align_items_normal_to_string() {
    expect(align_items(.normal).to_string()).to_be_equal_to("align-items:normal;")
}

fn test_it_render_align_items_revert_to_string() {
    expect(align_items(.revert).to_string()).to_be_equal_to("align-items:revert;")
}

fn test_it_render_align_items_revert_layer_to_string() {
    expect(align_items(.revert_layer).to_string()).to_be_equal_to("align-items:revert-layer;")
}

fn test_it_render_align_items_safe_center_to_string() {
    expect(align_items(.safe_center).to_string()).to_be_equal_to("align-items:safe center;")
}

fn test_it_render_align_items_self_end_to_string() {
    expect(align_items(.self_end).to_string()).to_be_equal_to("align-items:self-end;")
}

fn test_it_render_align_items_self_start_to_string() {
    expect(align_items(.self_start).to_string()).to_be_equal_to("align-items:self-start;")
}

fn test_it_render_align_items_start_to_string() {
    expect(align_items(.start).to_string()).to_be_equal_to("align-items:start;")
}

fn test_it_render_align_items_stretch_to_string() {
    expect(align_items(.stretch).to_string()).to_be_equal_to("align-items:stretch;")
}

fn test_it_render_align_items_unsafe_center_to_string() {
    expect(align_items(.unsafe_center).to_string()).to_be_equal_to("align-items:unsafe center;")
}

fn test_it_render_align_items_unset_to_string() {
    expect(align_items(.unset).to_string()).to_be_equal_to("align-items:unset;")
}
