module property

// https://developer.mozilla.org/fr/docs/Web/CSS/display
pub enum Display {
    block
    block_flow
    contents
    flex
    flex_run_in
    flow
    flow_list_item_block
    flow_root
    grid
    inherit
    initial
    inline
    inline_block
    inline_flex
    inline_grid
    inline_table
    inline__table
    list_item
    list_item_block
    list_item_block_flow
    list_item_block_flow_root
    list_item_flow
    list_item_flow_root
    list_item_inline
    none
    ruby
    ruby_base
    ruby_base_container
    ruby_text
    ruby_text_container
    run_in
    table
    table_caption
    table_cell
    table_column
    table_column_group
    table_footer_group
    table_header_group
    table_row
    table_row_group
    unset
}

pub fn (display Display) to_string() string {
    return match display {
        .block { "block" }
        .block_flow { "block flow" }
        .contents { "contents" }
        .flex { "flex" }
        .flex_run_in { "flex run-in" }
        .flow { "flow" }
        .flow_list_item_block { "flow list-item block" }
        .flow_root { "flow-root" }
        .grid { "grid" }
        .inherit { "inherit" }
        .initial { "initial" }
        .inline { "inline" }
        .inline_block { "inline-block" }
        .inline_flex { "inline-flex" }
        .inline_grid { "inline-grid" }
        .inline_table { "inline-table" }
        .inline__table { "inline table" }
        .list_item { "list-item" }
        .list_item_block { "list-item block" }
        .list_item_block_flow { "list-item block flow" }
        .list_item_block_flow_root { "list-item block flow-root" }
        .list_item_flow { "list-item flow" }
        .list_item_flow_root { "list-item flow-root" }
        .list_item_inline { "list-item inline" }
        .none { "none" }
        .ruby { "ruby" }
        .ruby_base { "ruby-base" }
        .ruby_base_container { "ruby-base-container" }
        .ruby_text { "ruby-text" }
        .ruby_text_container { "ruby-text-container" }
        .run_in { "run-in" }
        .table { "table" }
        .table_caption { "table-caption" }
        .table_cell { "table-cell" }
        .table_column { "table-column" }
        .table_column_group { "table-column-group" }
        .table_footer_group { "table-footer-group" }
        .table_header_group { "table-header-group" }
        .table_row { "table-row" }
        .table_row_group { "table-row-group" }
        .unset { "unset" }
    }
}
