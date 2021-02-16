view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  # dimension: test_product {
  #   sql: ${products.brand} ;;
  # }

  dimension: age_tier {
    type: tier
    style: integer
    tiers: [15, 50]
    sql: ${age} ;;
  }

  measure: max_id {
    type: max
    sql: ${id} ;;
  }

  measure: is_max {
    type: yesno
    sql: ${max_id}=${id} ;;
  }

  dimension: subquery {
    type: number
    sql: (select max(id) from users) ;;
  }

  dimension: sub_yesno {
    type: yesno
    sql: ${id}=${subquery} ;;
  }



  parameter: age_parameter {
    allowed_value: {
      value: "Below 15"
    }
    allowed_value: {
      value: "15 to 49"
    }
    allowed_value: {
      value: "50 or above"
    }
  }

  dimension: age_yesno {
    type: yesno
    sql: CASE WHEN {% parameter age_parameter %}="15 to 49" then (CASE WHEN ${age_tier}= "15 to 49" THEN TRUE else FALSE end) else null end;;
  }

  dimension: age_yesno_2 {
    type: yesno
    sql: {% parameter age_parameter %}=${age_tier} ;;
  }

  dimension: hide_yesno {
    type: yesno
    sql: ${age}>=30 ;;
  }



  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: should_be_hidden {
    label: "1. SHOULD BE HIDDEN"
    sql: "test" ;;
    hidden: yes
  }

  dimension: comma {
    type: string
    sql: concat(${city}, ", ", ${state}) ;;
    link: {
      label: "this one works"
      url: "/explore/sarah_ecomm/order_items?fields=users.email&f[users.comma]= {{filterable_value | url_encode }}"
    }
    link: {
      label: "this one doesn't work"
      url: "/explore/sarah_ecomm/order_items?fields=users.email&f[users.comma]= {{ filterable_value }}"
    }
    link: {
      label: "also doesn't work"
      url: "/explore/sarah_ecomm/order_items?fields=users.email&f[users.comma]= {{ value | url_encode }}"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    link: {
      label: "for ._filterable_value"
      url: "/explore/sarah_ecomm/order_items?fields=users.email&f[users.comma]={{users.comma._filterable_value | url_encode }}"
      #need to use ._filterable_value and url_encode
    }
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    # link: {
    #   label: "Click here for Dash B"
    #   url: "/dashboards/832?Dash%20B%20Date%20Filter={{ _filters['orders.created_date'] }}&First%20Name={{value}}&Gender={{users.gender._value}}"
    # }
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_female {
    type: yesno
    sql: ${gender}="f" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    link: {
      label: "Click here for Dash B"
      url: "/dashboards/832?Dash%20B%20Date%20Filter={{ _filters['orders.created_date'] }}&Last%20Name={{ value }}&Gender={{users.gender._value}}"
    }
    link: {
      label: "Click here for explore"
      url: "/explore/sarah_ecomm/orders?fields=users.email,users.state,users.zip&f[users.last_name]={{value}}&f[orders.created_date]={{ _filters['orders.created_date'] }}"
    }
  }

  dimension: dummy {
    sql: 1=1 ;;
    html: <a href="/dashboards/832?Dash%20B%20Date%20Filter={{ _filters['orders.created_date'] }}"> Click here </a> ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
  }

  parameter: state_parameter {
    type: string
    suggest_explore: users
    suggest_dimension: state
  }

  filter: state_filter {
    type: string
    suggest_explore: users
    suggest_dimension: state
  }

  dimension: dimstatefilter {
    type: string
    sql: {% condition state_filter %} ${state} {% endcondition %};;
  }

  dimension: yesnostateparameter {
    type: yesno
    sql: {% parameter state_parameter %} = ${state} ;;
  }



  dimension: statename {
    type: string
    sql: ${state} ;;
    html: {{rendered_value}} - {{first_name._rendered_value}} ;;
  }

  dimension: state_2 {
    type: string
    sql: CASE WHEN ${TABLE}.state="California" THEN "California" ELSE "Other" END ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }


  dimension: new_tab {
    type: string
    sql: ${state} ;;
    link: {
      url: "https://dcl.dev.looker.com/dashboards/1020"
      label: "should open new tab"
    }
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    link: {
      label: "click here"
      url: "
      {% assign vis_config = '{\"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"series_cell_visualizations\":{\"orders.count\":{\"is_active\":false}},\"type\":\"looker_grid\",\"defaults_version\":1}' %}
        {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    link: {
      label: "test2"
      url: "{{ link }}&series_cell_visualizations:{orders.count:{is_active:false}}"
      #url: "{{ link }}&limit=5"
    }
  }

  measure: count_test {
    type: count_distinct
    sql: ${state} ;;
  }

  measure: count2 {
    type: count
    drill_fields: [id, first_name]
    link: {
      label: "sarah"
      url: "https://google.com"
    }
  }

  measure: zip_count_dist {
    description: "this is my description"
    type: count_distinct
    sql: ${zip} ;;
    drill_fields: [zip]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      saralooker.count,
      user_data.count
    ]
  }
}
