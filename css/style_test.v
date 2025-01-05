import css { style, selector }
import css.property { display }
import test { expect }

fn test_it_can_render_class_selector_with_display_flex_item_to_string() {
    content := style([
        selector(".card-title", [
            display(.flex)
        ])
    ])

    expect(content).to_be_equal_to(".card-title{display:flex;}")
}
