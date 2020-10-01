- dashboard: trevor
  preferred_viewer: dashboards-next
  title: Dash A
  layout: newspaper
  elements:
  - title: Untitled
    name: Untitled
    model: sarah_ecomm
    explore: orders
    type: table
    fields: [orders.created_date, orders.id, orders.status, orders.count, orders.user_id,
      users.first_name, users.state]
    sorts: [orders.created_date desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Dash A Date Filter: orders.created_date
    row: 0
    col: 0
    width: 13
    height: 7
  filters:
  - name: Dash A Date Filter
    title: Dash A Date Filter
    type: field_filter
    default_value: 2019/12/21
    allow_multiple_values: true
    required: false
    model: sarah_ecomm
    explore: orders
    listens_to_filters: []
    field: orders.created_date
