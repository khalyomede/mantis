import css { Supports, SelectorBlock, Selector, Rule }
import css.property { Display, AlignItems }
import test { expect }

fn test_it_can_render_multiple_supports_statement_with_class_selector_and_display_flex_rule_to_string() {
    mut blocks := []SelectorBlock{}
    mut selector_blocks := []SelectorBlock{}

    selector_blocks << Rule {
        property: .display
        value: Display.flex.to_string()
    }

    blocks << Selector {
        selector: ".card-title"
        blocks: selector_blocks
    }

    supports := Supports {
        rules: [
            Rule {
                property: .display
                value: Display.flex.to_string()
                lonely: true
            }
            Rule {
                property: .align_items
                value: AlignItems.center.to_string()
                lonely: true
            }
        ]
        blocks: blocks
    }

    expect(supports.to_string()).to_be_equal_to("@supports(display:flex) and (align-items:center){.card-title{display:flex;}}")
}
