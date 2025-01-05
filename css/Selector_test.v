import css { Selector, Rule, SelectorBlock }
import css.property { Display }
import test { expect }

fn test_it_renders_class_selector_with_display_flex_rule_to_string() {
    mut blocks := []SelectorBlock{}

    blocks << Rule {
        property: .display
        value: Display.flex.to_string()
    }

    selector := Selector {
        selector: ".card-title"
        blocks: blocks
    }

    expect(selector.to_string()).to_be_equal_to(".card-title{display:flex;}")
}
