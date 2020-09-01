view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;
  drill_fields: [id]

  filter: thing {}

  dimension: a {
    sql: {% condition thing %} {% endcondition %};;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "test"
      url: "https://google.com"
    }
    link: {
      label: "test2"
      url: "https://google.com"
    }
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
    # hidden: yes
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
      label: "test2"
      url: "https://google.com"
    }
  }
}
