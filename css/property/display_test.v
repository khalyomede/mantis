import property { display }
import test { expect }

fn test_it_renders_display_flex_to_string() {
    expect(display(.flex).to_string()).to_be_equal_to("display:flex;")
}

fn test_renders_display_type_block_to_string() {
    expect(display(.block).to_string()).to_be_equal_to("display:block;")
}

fn test_renders_display_type_block_flow_to_string() {
    expect(display(.block_flow).to_string()).to_be_equal_to("display:block flow;")
}

fn test_renders_display_type_contents_to_string() {
    expect(display(.contents).to_string()).to_be_equal_to("display:contents;")
}

fn test_renders_display_type_flex_run_in_to_string() {
    expect(display(.flex_run_in).to_string()).to_be_equal_to("display:flex run-in;")
}

fn test_renders_display_type_flow_to_string() {
    expect(display(.flow).to_string()).to_be_equal_to("display:flow;")
}

fn test_renders_display_type_flow_list_item_block_to_string() {
    expect(display(.flow_list_item_block).to_string()).to_be_equal_to("display:flow list-item block;")
}

fn test_renders_display_type_flow_root_to_string() {
    expect(display(.flow_root).to_string()).to_be_equal_to("display:flow-root;")
}

fn test_renders_display_type_grid_to_string() {
    expect(display(.grid).to_string()).to_be_equal_to("display:grid;")
}

fn test_renders_display_type_inherit_to_string() {
    expect(display(.inherit).to_string()).to_be_equal_to("display:inherit;")
}

fn test_renders_display_type_initial_to_string() {
    expect(display(.initial).to_string()).to_be_equal_to("display:initial;")
}

fn test_renders_display_type_inline__table_to_string() {
    expect(display(.inline__table).to_string()).to_be_equal_to("display:inline table;")
}

fn test_renders_display_type_inline_block_to_string() {
    expect(display(.inline_block).to_string()).to_be_equal_to("display:inline-block;")
}

fn test_renders_display_type_inline_flex_to_string() {
    expect(display(.inline_flex).to_string()).to_be_equal_to("display:inline-flex;")
}

fn test_renders_display_type_inline_grid_to_string() {
    expect(display(.inline_grid).to_string()).to_be_equal_to("display:inline-grid;")
}

fn test_renders_display_type_inline_table_to_string() {
    expect(display(.inline_table).to_string()).to_be_equal_to("display:inline-table;")
}

fn test_renders_display_type_inline_to_string() {
    expect(display(.inline).to_string()).to_be_equal_to("display:inline;")
}

fn test_renders_display_type_list_item_to_string() {
    expect(display(.list_item).to_string()).to_be_equal_to("display:list-item;")
}

fn test_renders_display_type_list_item_block_to_string() {
    expect(display(.list_item_block).to_string()).to_be_equal_to("display:list-item block;")
}

fn test_renders_display_type_list_item_block_flow_to_string() {
    expect(display(.list_item_block_flow).to_string()).to_be_equal_to("display:list-item block flow;")
}

fn test_renders_display_type_list_item_block_flow_root_to_string() {
    expect(display(.list_item_block_flow_root).to_string()).to_be_equal_to("display:list-item block flow-root;")
}

fn test_renders_display_type_list_item_flow_to_string() {
    expect(display(.list_item_flow).to_string()).to_be_equal_to("display:list-item flow;")
}

fn test_renders_display_type_list_item_flow_root_to_string() {
    expect(display(.list_item_flow_root).to_string()).to_be_equal_to("display:list-item flow-root;")
}

fn test_renders_display_type_list_item_inline_to_string() {
    expect(display(.list_item_inline).to_string()).to_be_equal_to("display:list-item inline;")
}

fn test_renders_display_type_none_to_string() {
    expect(display(.none).to_string()).to_be_equal_to("display:none;")
}

fn test_renders_display_type_ruby_to_string() {
    expect(display(.ruby).to_string()).to_be_equal_to("display:ruby;")
}

fn test_renders_display_type_ruby_base_to_string() {
    expect(display(.ruby_base).to_string()).to_be_equal_to("display:ruby-base;")
}

fn test_renders_display_type_ruby_base_container_to_string() {
    expect(display(.ruby_base_container).to_string()).to_be_equal_to("display:ruby-base-container;")
}

fn test_renders_display_type_ruby_text_to_string() {
    expect(display(.ruby_text).to_string()).to_be_equal_to("display:ruby-text;")
}

fn test_renders_display_type_ruby_text_container_to_string() {
    expect(display(.ruby_text_container).to_string()).to_be_equal_to("display:ruby-text-container;")
}

fn test_renders_display_type_run_in_to_string() {
    expect(display(.run_in).to_string()).to_be_equal_to("display:run-in;")
}

fn test_renders_display_type_table_to_string() {
    expect(display(.table).to_string()).to_be_equal_to("display:table;")
}

fn test_renders_display_type_table_caption_to_string() {
    expect(display(.table_caption).to_string()).to_be_equal_to("display:table-caption;")
}

fn test_renders_display_type_table_cell_to_string() {
    expect(display(.table_cell).to_string()).to_be_equal_to("display:table-cell;")
}

fn test_renders_display_type_table_column_to_string() {
    expect(display(.table_column).to_string()).to_be_equal_to("display:table-column;")
}

fn test_renders_display_type_table_column_group_to_string() {
    expect(display(.table_column_group).to_string()).to_be_equal_to("display:table-column-group;")
}

fn test_renders_display_type_table_footer_group_to_string() {
    expect(display(.table_footer_group).to_string()).to_be_equal_to("display:table-footer-group;")
}

fn test_renders_display_type_table_header_group_to_string() {
    expect(display(.table_header_group).to_string()).to_be_equal_to("display:table-header-group;")
}

fn test_renders_display_type_table_row_to_string() {
    expect(display(.table_row).to_string()).to_be_equal_to("display:table-row;")
}

fn test_renders_display_type_table_row_group_to_string() {
    expect(display(.table_row_group).to_string()).to_be_equal_to("display:table-row-group;")
}

fn test_renders_display_type_unset_to_string() {
    expect(display(.unset).to_string()).to_be_equal_to("display:unset;")
}
