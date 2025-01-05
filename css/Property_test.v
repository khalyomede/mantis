import css
import test { expect }

fn test_it_renders_display_property_to_string() {
    expect(css.Property.display.to_string()).to_be_equal_to("display")
}

fn test_it_renders_align_items_property_to_string() {
    expect(css.Property.align_items.to_string()).to_be_equal_to("align-items")
}
