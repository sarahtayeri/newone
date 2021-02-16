view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;
  drill_fields: [id]

  filter: thing {}

  dimension: a {
    sql: {% condition thing %} {% endcondition %};;
  }

  parameter: custom_date {
    type: date
  }

  dimension: custom_date_start {
    sql: {% date_start custom_date %} ;;
  }

  dimension: custom_date_end {
    sql: {% date_end custom_date %} ;;
  }



  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "test"
      url: "https://dcl.dev.looker.com/explore/sarah_ecomm/orders"
    }
  }

  dimension: long_text {
    type: string
    sql: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ;;
  }



  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      fiscal_quarter,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  dimension: html_line_breaks {
    sql: ${product_id};;
    html: sarah <br> is the best ;;
  }


  measure: count {
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count]
    link: {
      label: "test1"
      url: "{{ link }}"
    }
    link: {
      label: "test with new drills"
      url: "{{ dummy_for_drill_fields._link }}"
    }
  }

  measure: dummy_for_drill_fields {
    hidden: yes
    type: count
    sql: 1=1;;
    drill_fields: [id, sold_date, cost]
  }





}
