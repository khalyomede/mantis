import property
import test { expect }

fn test_renders_display_type_flex_to_string() {
    expect(property.Display.flex.to_string()).to_be_equal_to("flex")
}

fn test_renders_display_type_block_to_string() {
    expect(property.Display.block.to_string()).to_be_equal_to("block")
}

fn test_renders_display_type_block_flow_to_string() {
    expect(property.Display.block_flow.to_string()).to_be_equal_to("block flow")
}

fn test_renders_display_type_contents_to_string() {
    expect(property.Display.contents.to_string()).to_be_equal_to("contents")
}

fn test_renders_display_type_flex_run_in_to_string() {
    expect(property.Display.flex_run_in.to_string()).to_be_equal_to("flex run-in")
}

fn test_renders_display_type_flow_to_string() {
    expect(property.Display.flow.to_string()).to_be_equal_to("flow")
}

fn test_renders_display_type_flow_list_item_block_to_string() {
    expect(property.Display.flow_list_item_block.to_string()).to_be_equal_to("flow list-item block")
}

fn test_renders_display_type_flow_root_to_string() {
    expect(property.Display.flow_root.to_string()).to_be_equal_to("flow-root")
}

fn test_renders_display_type_grid_to_string() {
    expect(property.Display.grid.to_string()).to_be_equal_to("grid")
}

fn test_renders_display_type_inherit_to_string() {
    expect(property.Display.inherit.to_string()).to_be_equal_to("inherit")
}

fn test_renders_display_type_initial_to_string() {
    expect(property.Display.initial.to_string()).to_be_equal_to("initial")
}

fn test_renders_display_type_inline__table_to_string() {
    expect(property.Display.inline__table.to_string()).to_be_equal_to("inline table")
}

fn test_renders_display_type_inline_block_to_string() {
    expect(property.Display.inline_block.to_string()).to_be_equal_to("inline-block")
}

fn test_renders_display_type_inline_flex_to_string() {
    expect(property.Display.inline_flex.to_string()).to_be_equal_to("inline-flex")
}

fn test_renders_display_type_inline_grid_to_string() {
    expect(property.Display.inline_grid.to_string()).to_be_equal_to("inline-grid")
}

fn test_renders_display_type_inline_table_to_string() {
    expect(property.Display.inline_table.to_string()).to_be_equal_to("inline-table")
}

fn test_renders_display_type_inline_to_string() {
    expect(property.Display.inline.to_string()).to_be_equal_to("inline")
}

fn test_renders_display_type_list_item_to_string() {
    expect(property.Display.list_item.to_string()).to_be_equal_to("list-item")
}

fn test_renders_display_type_list_item_block_to_string() {
    expect(property.Display.list_item_block.to_string()).to_be_equal_to("list-item block")
}

fn test_renders_display_type_list_item_block_flow_to_string() {
    expect(property.Display.list_item_block_flow.to_string()).to_be_equal_to("list-item block flow")
}

fn test_renders_display_type_list_item_block_flow_root_to_string() {
    expect(property.Display.list_item_block_flow_root.to_string()).to_be_equal_to("list-item block flow-root")
}

fn test_renders_display_type_list_item_flow_to_string() {
    expect(property.Display.list_item_flow.to_string()).to_be_equal_to("list-item flow")
}

fn test_renders_display_type_list_item_flow_root_to_string() {
    expect(property.Display.list_item_flow_root.to_string()).to_be_equal_to("list-item flow-root")
}

fn test_renders_display_type_list_item_inline_to_string() {
    expect(property.Display.list_item_inline.to_string()).to_be_equal_to("list-item inline")
}

fn test_renders_display_type_none_to_string() {
    expect(property.Display.none.to_string()).to_be_equal_to("none")
}

fn test_renders_display_type_ruby_to_string() {
    expect(property.Display.ruby.to_string()).to_be_equal_to("ruby")
}

fn test_renders_display_type_ruby_base_to_string() {
    expect(property.Display.ruby_base.to_string()).to_be_equal_to("ruby-base")
}

fn test_renders_display_type_ruby_base_container_to_string() {
    expect(property.Display.ruby_base_container.to_string()).to_be_equal_to("ruby-base-container")
}

fn test_renders_display_type_ruby_text_to_string() {
    expect(property.Display.ruby_text.to_string()).to_be_equal_to("ruby-text")
}

fn test_renders_display_type_ruby_text_container_to_string() {
    expect(property.Display.ruby_text_container.to_string()).to_be_equal_to("ruby-text-container")
}

fn test_renders_display_type_run_in_to_string() {
    expect(property.Display.run_in.to_string()).to_be_equal_to("run-in")
}

fn test_renders_display_type_table_to_string() {
    expect(property.Display.table.to_string()).to_be_equal_to("table")
}

fn test_renders_display_type_table_caption_to_string() {
    expect(property.Display.table_caption.to_string()).to_be_equal_to("table-caption")
}

fn test_renders_display_type_table_cell_to_string() {
    expect(property.Display.table_cell.to_string()).to_be_equal_to("table-cell")
}

fn test_renders_display_type_table_column_to_string() {
    expect(property.Display.table_column.to_string()).to_be_equal_to("table-column")
}

fn test_renders_display_type_table_column_group_to_string() {
    expect(property.Display.table_column_group.to_string()).to_be_equal_to("table-column-group")
}

fn test_renders_display_type_table_footer_group_to_string() {
    expect(property.Display.table_footer_group.to_string()).to_be_equal_to("table-footer-group")
}

fn test_renders_display_type_table_header_group_to_string() {
    expect(property.Display.table_header_group.to_string()).to_be_equal_to("table-header-group")
}

fn test_renders_display_type_table_row_to_string() {
    expect(property.Display.table_row.to_string()).to_be_equal_to("table-row")
}

fn test_renders_display_type_table_row_group_to_string() {
    expect(property.Display.table_row_group.to_string()).to_be_equal_to("table-row-group")
}

fn test_renders_display_type_unset_to_string() {
    expect(property.Display.unset.to_string()).to_be_equal_to("unset")
}

