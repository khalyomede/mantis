import css { Rule }
import css.property
import test { expect }

fn test_it_renders_display_flex_css_rule() {
    rule := Rule {
        property: .display
        value: property.Display.flex.to_string()
    }

    expect(rule.to_string()).to_be_equal_to("display:flex;")
}
