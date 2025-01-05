import css { selector }
import css.property { display }
import test { expect }

fn test_it_can_render_class_selector_with_display_flex_to_string() {
    selector := selector(".card-title", [
        display(.flex)
    ])

    expect(selector.to_string()).to_be_equal_to(".card-title{display:flex;}")
}
