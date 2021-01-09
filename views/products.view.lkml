view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]


  parameter: id_param {
    #suggest_dimension:
  }

  parameter: id_deanna_param {}

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: variance {
    type: number
    sql: variance(${id}) ;;
  }



  measure: variance_2 {
    type: number
    sql: variance(${count}) ;;
  }

  dimension: id_faked {
    type: number
    sql: case when ${id}>20 and ${id}<30 then null else ${id} end ;;
  }

  dimension: id_deanna {
    type: number
    sql: ${id}+1 ;;
  }



  filter: example {}

  parameter: test_link {
    type: unquoted
    allowed_value: {
      value: "apple"
    }
    allowed_value: {
      value: "banana"
    }
  }

  dimension: asldkfj {
    type: string
    sql: {% if test_link._parameter_value == 'apple' %} "this is a" {% elsif test_link._parameter_value == 'banana' %} "this is b" {% else %} "broken" {% endif %};;
    #sql: {% parameter test_link %} ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }


  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  measure: department_m {
    type: string
    sql: ${department} ;;
  }

  measure: category_m {
    type: string
    sql: ${category} ;;
  }

  measure: count_of_categories {
    type: count_distinct
    sql: ${category} ;;
  }


  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  # dimension: site {
  #   type: string
  #   sql: ${department} ;;
  #   link: {
  #     url: "{{page._value}}"
  #     label: "{{page._value}}"
  #   }
  # }

  dimension: link_nick {
    type: string
    sql: "@{nick_constant}" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
    link: {
      label: "irene"
      url: "{{link}}&fields=products.id,products.item_name,inventory_items.count&sorts=inventory_items.count+desc&limit=5&query_timezone=America%2FLos_Angeles&vis=%7B%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22white%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A12%2C%22rows_font_size%22%3A12%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22defaults_version%22%3A1%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%7D&origin=share-expanded"


      ## https://dcl.dev.looker.com/explore/sarah_ecomm/order_items?fields=products.id,products.item_name,inventory_items.count&sorts=inventory_items.count+desc&limit=5&query_timezone=America%2FLos_Angeles&vis=%7B%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%2C%22show_row_numbers%22%3Atrue%2C%22transpose%22%3Afalse%2C%22truncate_text%22%3Atrue%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22size_to_fit%22%3Atrue%2C%22table_theme%22%3A%22white%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22header_text_alignment%22%3A%22left%22%2C%22header_font_size%22%3A12%2C%22rows_font_size%22%3A12%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22defaults_version%22%3A1%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%7D&origin=share-expanded
    }
  }

  measure: price_sum {
    type: sum
    sql: ${retail_price} ;;
  }

  measure: pot_sum {
    type: percent_of_total
    sql: ${price_sum} ;;
  }

  measure: usd_plus {
    value_format_name: "usd"
    type: number
    sql: ${count}+1 ;;
    html: {{rendered_value}} || {{products.count._rendered_value}} ;;
  }

  measure: filtered_count {
    type: count
    filters: [id: ">100"]
  }
}
